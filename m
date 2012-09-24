From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Sep 2012 09:22:22 +0200
Subject: [PATCH] mmc: sdhci / i.MX esdhc buswidth patches
Message-ID: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch is a generic sdhci driver cleanup change, the others
are i.MX specific, adding 8bit bus support and fix version register
readout.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      mmc: sdhci: rename platform_8bit_width to platform_bus_width
      mmc: esdhc i.MX: Fix version register read
      mmc: esdhc i.MX: Support 8bit mode

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    1 +
 arch/arm/plat-mxc/include/mach/esdhc.h             |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   77 +++++++++++++++++---
 drivers/mmc/host/sdhci-pci.c                       |    4 +-
 drivers/mmc/host/sdhci-pxav2.c                     |    2 +-
 drivers/mmc/host/sdhci-s3c.c                       |    8 +-
 drivers/mmc/host/sdhci-tegra.c                     |    4 +-
 drivers/mmc/host/sdhci.c                           |    8 +-
 drivers/mmc/host/sdhci.h                           |    2 +-
 9 files changed, 82 insertions(+), 25 deletions(-)
