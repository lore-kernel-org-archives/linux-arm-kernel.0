From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Aug 2013 14:16:00 +0200
Subject: [PATCH] dma: imx-sdma: Add ROM script addresses to driver
Message-ID: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series adds the ROM script addresses to the driver.
These have been provided by platform_data for platform based systems,
but with devicetree the driver no longer supports the ROM script
addresses. This means that the sdma driver currently needs a firmware
to work. By adding the script addresses to the driver it can work
without additional firmware.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      dma: imx-sdma: Use struct for driver data
      dma: imx-sdma: Add ROM script addresses to driver
      ARM: i.MX: remove sdma script address arrays from platform data

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   7 +-
 arch/arm/mach-imx/mm-imx25.c                       |  17 --
 arch/arm/mach-imx/mm-imx3.c                        |  67 ++----
 arch/arm/mach-imx/mm-imx5.c                        |  14 --
 drivers/dma/imx-sdma.c                             | 241 ++++++++++++++++++---
 5 files changed, 230 insertions(+), 116 deletions(-)
