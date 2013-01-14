From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon, 14 Jan 2013 11:15:42 +0100
Subject: [GIT PULL] ste_dma40 updates for 3.9
Message-ID: <20130114101542.GA5363@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Olof,

This contains a series of updates and fixes for the ste_dma40 driver.

The driver is specific for the ux500, and the patches were acked by both Linus
Walleij, and Vinod Koul (dmaengine), who agreed to push this through arm-soc.

Can you please pull those in for -next?

Thanks,
Fabio


The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.linaro.org/people/fabiobaltieri/linux.git tags/ux500-dma40

for you to fetch changes up to da2ac56a1bc9c6c56244aa9ca990d5c5c7574b5f:

  dmaengine: set_dma40: balance clock in probe fail code (2013-01-14 10:51:16 +0100)

----------------------------------------------------------------
Various fixes and updates for the ste_dma40 driver.

----------------------------------------------------------------
Fabio Baltieri (7):
      dmaengine: ste_dma40: add a done queue for completed descriptors
      dmaengine: ste_dma40: add missing kernel-doc entry
      dmaengine: ste_dma40: minor cosmetic fixes
      dmaengine: ste_dma40: minor code readability fixes
      dmaengine: ste_dma40: add software lli support
      dmaengine: set_dma40: ignore spurious interrupts
      dmaengine: set_dma40: balance clock in probe fail code

Gerald Baeza (2):
      dmaengine: ste_dma40: support fixed physical channel allocation
      dmaengine: ste_dma40: physical channels number correction

Narayanan (1):
      dmaengine: ste_dma40: reset priority bit for logical channels

Narayanan G (1):
      dmaengine: ste_dma40: don't check for pm_runtime_suspended()

Per Forlin (3):
      dmaengine: ste_dma40: use writel_relaxed for lcxa
      dmaengine: ste_dma40: set dma max seg size
      dmaengine: ste_dma40: limit burst size to 16

Rabin Vincent (1):
      dmaengine: ste_dma40: don't allow high priority dest event lines

Tong Liu (1):
      dmaengine: ste_dma40: support more than 128 event lines

 drivers/dma/ste_dma40.c                     | 489 +++++++++++++++++++++-------
 drivers/dma/ste_dma40_ll.c                  |  29 +-
 drivers/dma/ste_dma40_ll.h                  | 130 +++++++-
 include/linux/platform_data/dma-ste-dma40.h |  13 +
 4 files changed, 518 insertions(+), 143 deletions(-)

-- 
Fabio Baltieri
