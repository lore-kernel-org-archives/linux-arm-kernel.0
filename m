From: b42378@freescale.com (Nicolin Chen)
Date: Tue, 29 Oct 2013 20:33:14 +0800
Subject: [PATCH 0/3] Add dual-fifo mode support of i.MX ssi
Message-ID: <cover.1383047327.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog
v1:
 * SSI can reduce hardware overrun/underrun possibility when using dual
 * fifo mode. To support this mode, we need to first update sdma sciprt
 * list, and then enable dual fifo BIT in SSI driver, and last update DT
 * bindings of i.MX series.
 *
 * ! This series of patches has a direct dependency between them. When
 * ! applying them, we need to apply in one single branch. Otherwise,
 * ! it would break currect branches.

Nicolin Chen (3):
  dma: imx-sdma: Add ssi dual fifo script support
  ASoC: fsl_ssi: Add dual fifo mode support
  ARM: dts: imx: use dual-fifo sdma script for ssi

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 arch/arm/boot/dts/imx51.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx53.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi                     | 12 +++++------
 arch/arm/boot/dts/imx6sl.dtsi                      | 12 +++++------
 drivers/dma/imx-sdma.c                             |  6 +++++-
 include/linux/platform_data/dma-imx-sdma.h         |  2 ++
 include/linux/platform_data/dma-imx.h              |  1 +
 sound/soc/fsl/fsl_ssi.c                            | 24 +++++++++++++++++++++-
 9 files changed, 48 insertions(+), 18 deletions(-)

-- 
1.8.4
