From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 22:23:09 +0800
Subject: [PATCH 0/6] Add device tree support for mxs-dma
Message-ID: <1336400595-12964-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a rebase of Dong Aisheng's patchset on common-clk
and pinctrl.  It also adds one patch to address Marek's comment
on dma_is_apbh and apbh_is_old macros.

Dong Aisheng (5):
  dma: mxs-dma: use global stmp_device functionality
  dma: mxs-dma: make platform_device_id more generic
  dma: mxs-dma: add device tree probe support
  ARM: mxs: do not add dma device by default
  ARM: mxs: add mxs-dma dt support

Shawn Guo (1):
  dma: mxs-dma: let dma_is_apbh and apbh_is_old take parameter

 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   19 ++
 arch/arm/boot/dts/imx23.dtsi                       |    4 +-
 arch/arm/boot/dts/imx28.dtsi                       |    4 +-
 arch/arm/mach-mxs/devices/platform-dma.c           |   21 +--
 arch/arm/mach-mxs/include/mach/common.h            |    3 +
 arch/arm/mach-mxs/mm.c                             |    6 +
 drivers/clk/mxs/clk-imx23.c                        |    4 +-
 drivers/clk/mxs/clk-imx28.c                        |    4 +-
 drivers/dma/Kconfig                                |    1 +
 drivers/dma/mxs-dma.c                              |  184 +++++++++++++-------
 include/linux/fsl/mxs-dma.h                        |   12 +-
 11 files changed, 163 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt

-- 
1.7.5.4
