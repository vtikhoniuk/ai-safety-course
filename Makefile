OLLAMA  ?= ollama

GEMMA4  ?= gemma4:e4b
QWEN25  ?= qwen2.5:3b
QWEN3   ?= qwen3:4b
QWEN3_8 ?= qwen3:8b
LLAMA2  ?= llama2

.PHONY: help serve stop status list \
        pull-gemma4 pull-qwen25 pull-qwen3 pull-qwen3-8 pull-llama2 pull-all \
        gemma4 qwen25 qwen3 qwen3-8 llama2 \
        rm-gemma4 rm-qwen25 rm-qwen3 rm-qwen3-8 rm-llama2

help:
	@echo "Ollama local models"
	@echo ""
	@echo "  make serve           — start ollama daemon"
	@echo "  make stop            — stop ollama daemon"
	@echo "  make status          — show running models"
	@echo "  make list            — list installed models"
	@echo ""
	@echo "  make pull-gemma4     — download $(GEMMA4)"
	@echo "  make pull-qwen25     — download $(QWEN25)"
	@echo "  make pull-qwen3      — download $(QWEN3)"
	@echo "  make pull-qwen3-8    — download $(QWEN3_8)"
	@echo "  make pull-llama2     — download $(LLAMA2)"
	@echo "  make pull-all        — download all five"
	@echo ""
	@echo "  make gemma4          — chat with $(GEMMA4)"
	@echo "  make qwen25          — chat with $(QWEN25)"
	@echo "  make qwen3           — chat with $(QWEN3)"
	@echo "  make qwen3-8         — chat with $(QWEN3_8)"
	@echo ""
	@echo "  make llama2          — chat with $(LLAMA2)"
	@echo ""
	@echo "  make rm-gemma4 | rm-qwen25 | rm-qwen3 | rm-qwen3-8 | rm-llama2 — delete a model"

serve:
	@pgrep -x ollama >/dev/null && echo "ollama already running" || \
		(nohup $(OLLAMA) serve > /tmp/ollama.log 2>&1 & echo "started, log: /tmp/ollama.log")
	@sleep 1

stop:
	@pkill -x ollama && echo "stopped" || echo "not running"

status:
	@$(OLLAMA) ps

list: serve
	$(OLLAMA) list

pull-gemma4: serve
	$(OLLAMA) pull $(GEMMA4)

pull-qwen25: serve
	$(OLLAMA) pull $(QWEN25)

pull-qwen3: serve
	$(OLLAMA) pull $(QWEN3)

pull-qwen3-8: serve
	$(OLLAMA) pull $(QWEN3_8)

pull-llama2: serve
	$(OLLAMA) pull $(LLAMA2)

pull-all: pull-gemma4 pull-qwen25 pull-qwen3 pull-qwen3-8 pull-llama2

gemma4: serve
	$(OLLAMA) run $(GEMMA4)

qwen25: serve
	$(OLLAMA) run $(QWEN25)

qwen3: serve
	$(OLLAMA) run $(QWEN3)

qwen3-8: serve
	$(OLLAMA) run $(QWEN3_8)

llama2: serve
	$(OLLAMA) run $(LLAMA2)

rm-gemma4:
	$(OLLAMA) rm $(GEMMA4)

rm-qwen25:
	$(OLLAMA) rm $(QWEN25)

rm-qwen3:
	$(OLLAMA) rm $(QWEN3)

rm-qwen3-8:
	$(OLLAMA) rm $(QWEN3_8)

rm-llama2:
	$(OLLAMA) rm $(LLAMA2)
