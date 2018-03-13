From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 13 Mar 2018 17:41:59 +0100
Subject: [PATCH v1 0/8] Append several fixes and improvements in STM32 DMA
Message-ID: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset appends several fixes and some improvements for STM32 DMAv2.
This includes:
        * Introduce DMA features bitfield
        * Threshold manages with bitfield feature
        * Improve memory burst management
        * Improve DMA IRQ status handling
        * Fix max items per transfer to match FIFO Size
        * Properly mask irq bits to avoid overlaping
        * Fix incomplete configuration in cyclic mode
        * Fix typo and reported checkpatch warnings

---
  Version history:
    v1:
        * Initial
---

Pierre-Yves MORDRET (8):
  dt-bindings: stm32-dma: introduce DMA features bitfield
  dmaengine: stm32-dma: threshold manages with bitfield feature
  dmaengine: stm32-dma: Improve memory burst management
  dmaengine: stm32-dma: fix DMA IRQ status handling
  dmaengine: stm32-dma: fix max items per transfer
  dmaengine: stm32-dma: properly mask irq bits
  dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
  dmaengine: stm32-dma: fix typo and reported checkpatch warnings

 .../devicetree/bindings/dma/stm32-dma.txt          |   6 +-
 drivers/dma/stm32-dma.c                            | 287 +++++++++++++++++----
 2 files changed, 243 insertions(+), 50 deletions(-)

-- 
2.7.4
