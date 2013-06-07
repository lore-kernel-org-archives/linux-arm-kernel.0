From: tony@atomide.com (Tony Lindgren)
Date: Fri, 07 Jun 2013 14:49:44 -0700
Subject: [PATCH 0/4] Updated omap_hsmmc SDIO and remuxing patches
Message-ID: <20130607214557.18581.75288.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are the update SDIO remuxing patches that are based on Andreas'
earlier patches. The remuxing part is still in discussion, but that
can be merged later in case there's some way to do it automatically
at the drivers/base/pinctrl.c level.

I've used these patches successfully with wl12xx and mwifiex_sdio
on at least omap3 zoom, omap3 evm, omap4 sdp, and panda es.

Regards,

Tony

---

Andreas Fenkart (2):
      mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in idle mode
      mmc: omap_hsmmc: debugfs entries for GPIO and SDIO mode

Tony Lindgren (2):
      mmc: omap_hsmmc: Fix context save and restore for DT
      mmc: omap_hsmmc: Remux pins to support SDIO interrupt and PM runtime


 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   42 ++
 drivers/mmc/host/omap_hsmmc.c                      |  356 +++++++++++++++++---
 include/linux/platform_data/mmc-omap.h             |    4 
 3 files changed, 351 insertions(+), 51 deletions(-)

-- 
Signature
