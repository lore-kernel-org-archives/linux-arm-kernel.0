From: afenkart@gmail.com (Andreas Fenkart)
Date: Sat,  5 Oct 2013 13:17:06 +0200
Subject: [PATCH v3 0/4] mmc: omap_hsmmc: SDIO irq
Message-ID: <1380971830-21492-1-git-send-email-afenkart@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes:
- split the subject patch into normal handling and
  workaround for am335x
- rebase

Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO IRQ.
  mmc: omap_hsmmc: Remux pins to support SDIO interrupt on AM335x
  mmc: omap_hsmmc: debugfs for SDIO IRQ and GPIO remux

Tony Lindgren (1):
  mmc: omap_hsmmc: Fix context save and restore for DT

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   42 +++
 drivers/mmc/host/omap_hsmmc.c                      |  363 +++++++++++++++++---
 include/linux/platform_data/mmc-omap.h             |    4 +
 3 files changed, 357 insertions(+), 52 deletions(-)

-- 
1.7.10.4
