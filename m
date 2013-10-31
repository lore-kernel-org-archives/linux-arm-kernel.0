From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 31 Oct 2013 14:32:02 +0800
Subject: [PATCH v2 0/4] Add dual-fifo mode support of i.MX ssi
Message-ID: <cover.1383197521.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog
v2:
 * Instead of adding rogue scripts to current SDMA driver based on firmware
 * V1, we define the new SDMA firmware as version 2 and bisect the PATCH-1
 * to two patches: The first is to add version check code to the SDMA driver;
 * And the second is to add SSI dual FIFO DMATYPE.
 *
 * Nothing changes for the last two patches.
v1:
 * SSI can reduce hardware overrun/underrun possibility when using dual
 * fifo mode. To support this mode, we need to first update sdma sciprt
 * list, and then enable dual fifo BIT in SSI driver, and last update DT
 * bindings of i.MX series.
 *
 * ! This series of patches has a direct dependency between them. When
 * ! applying them, we need to apply in one single branch. Otherwise,
 * ! it would break currect branches.

Nicolin Chen (4):
  dma: imx-sdma: Add sdma firmware version 2 support
  dma: imx-sdma: Add new dma type for ssi dual fifo script
  ASoC: fsl_ssi: Add dual fifo mode support
  ARM: dts: imx: use dual-fifo sdma script for ssi

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 arch/arm/boot/dts/imx51.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx53.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi                     | 12 +++++------
 arch/arm/boot/dts/imx6sl.dtsi                      | 12 +++++------
 drivers/dma/imx-sdma.c                             | 19 ++++++++++++++++-
 include/linux/platform_data/dma-imx-sdma.h         |  3 +++
 include/linux/platform_data/dma-imx.h              |  1 +
 sound/soc/fsl/fsl_ssi.c                            | 24 +++++++++++++++++++++-
 9 files changed, 62 insertions(+), 18 deletions(-)

-- 
1.8.4
