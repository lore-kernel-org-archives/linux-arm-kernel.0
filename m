From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon,  7 Jan 2013 12:21:42 +0100
Subject: [PATCH v2 00/16] various fixes and updates for ste_dma40
Message-ID: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series contains many fixes and updates for the ste_dma40 driver.

The first patches of the series were originally sent weeks ago but did not
receive any feedback, so I'm also resending those, but I've rebased everything
on top of v3.8-rc2 to avoid a (trivial) file rename conflict.

Vinod, these should probably end up in the arm-soc tree so they can receive
some testing from drivers using it.  Can I have your Acked-by for this?

Thanks,
Fabio


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
1.7.12.1
