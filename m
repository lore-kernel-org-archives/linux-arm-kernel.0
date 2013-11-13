From: b42378@freescale.com (Nicolin Chen)
Date: Wed, 13 Nov 2013 22:55:23 +0800
Subject: [PATCH v7 0/4] Add dual-fifo mode support of i.MX ssi
Message-ID: <cover.1384352281.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 * ! This series of patches has a direct dependency between them. When
 * ! applying them, we need to apply to one single branch. Otherwise,
 * ! it would break currect branches.

Changelog
v7:
 * Appended missing Acked-by to all four patches.
 * Sorry that I didn't add them at the first place.
v6:
 * PATCH-1: Use goto err_firmware instead of return directly.
 *
 * Nothing changes for the other three ack-ed patches
v5:
 * PATCH-3: Add period size constraint when using dual fifo mode
 *
 * Nothing changes for the other three patches
v4:
 * PATCH-3: Drop useless register configuration.
 *
 * Nothing changes for the other three patches
v3:
 * PATCH-1: Add comments to indicate the end of v1 and v2 array.
 * PATCH-3: Use better way to keep watermark as even number.
 *
 * Nothing changes for PATCH-2 and PATCH-4
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

Nicolin Chen (4):
  dma: imx-sdma: Add sdma firmware version 2 support
  dma: imx-sdma: Add new dma type for ssi dual fifo script
  ASoC: fsl_ssi: Add dual fifo mode support
  ARM: dts: imx: use dual-fifo sdma script for ssi

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 arch/arm/boot/dts/imx51.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx53.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi                     | 12 +++++-----
 arch/arm/boot/dts/imx6sl.dtsi                      | 12 +++++-----
 drivers/dma/imx-sdma.c                             | 19 ++++++++++++++-
 include/linux/platform_data/dma-imx-sdma.h         |  5 ++++
 include/linux/platform_data/dma-imx.h              |  1 +
 sound/soc/fsl/fsl_ssi.c                            | 27 +++++++++++++++++++++-
 9 files changed, 67 insertions(+), 18 deletions(-)

-- 
1.8.4
