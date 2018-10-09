From: joel@joelfernandes.org (Joel Fernandes (Google))
Date: Mon,  8 Oct 2018 22:47:45 -0700
Subject: [PATCH 0/7] NULL pointer deref fix for stm32-dma
Message-ID: <20181009054752.145978-1-joel@joelfernandes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

While looking at android-4.14, I found a NULL pointer deref with
stm32-dma driver using Coccicheck errors. I found that upstream had a
bunch of patches on stm32-dma that have fixed this and other issues, I
applied these patches cleanly onto Android 4.14. I believe these should
goto stable and flow into Android 4.14 from there, but I haven't tested
this since I have no hardware to do so.

Atleast I can say that the coccicheck error below goes away when running:
make coccicheck MODE=report
./drivers/dma/stm32-dma.c:567:18-24: ERROR: chan -> desc is NULL but dereferenced.

Anyway, please consider this series for 4.14 stable, I have CC'd the
author and others, thanks.

Pierre Yves MORDRET (7):
  dmaengine: stm32-dma: threshold manages with bitfield feature
  dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
  dmaengine: stm32-dma: fix typo and reported checkpatch warnings
  dmaengine: stm32-dma: Improve memory burst management
  dmaengine: stm32-dma: fix DMA IRQ status handling
  dmaengine: stm32-dma: fix max items per transfer
  dmaengine: stm32-dma: properly mask irq bits

 drivers/dma/stm32-dma.c | 287 +++++++++++++++++++++++++++++++++-------
 1 file changed, 240 insertions(+), 47 deletions(-)

-- 
2.19.0.605.g01d371f741-goog
