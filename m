From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Aug 2013 10:04:30 +0200
Subject: [PATCH v2] dma: imx-sdma: Add ROM script addresses to driver
Message-ID: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:

- skip handling of SoCs which have a tapeout specific SDMA firmware,
  namely i.MX31/35

----------------------------------------------------------------
Sascha Hauer (3):
      dma: imx-sdma: Use struct for driver data
      dma: imx-sdma: Add ROM script addresses to driver
      ARM: i.MX: remove sdma script address arrays from platform data

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   7 +-
 arch/arm/mach-imx/mm-imx25.c                       |  17 ---
 arch/arm/mach-imx/mm-imx5.c                        |  14 --
 drivers/dma/imx-sdma.c                             | 161 +++++++++++++++++----
 4 files changed, 137 insertions(+), 62 deletions(-)
