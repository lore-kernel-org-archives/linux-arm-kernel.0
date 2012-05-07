From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 22:43:02 +0800
Subject: [PATCH 00/10] Add device tree support for mxs-mmc
Message-ID: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds device tree support for mxs-mmc based on mxs
common-clk, pinctrl, and DT support for mxs gpio and dma.

Shawn Guo (10):
  mmc: mxs-mmc: use global stmp_device functionality
  mmc: mxs-mmc: let ssp_is_old take host as parameter
  mmc: mxs-mmc: get rid of the use of cpu_is_xxx
  mmc: mxs-mmc: move header from mach into linux folder
  mmc: mxs-mmc: use devm_* helper to make cleanup simpler
  mmc: mxs-mmc: have dma_channel than dma_res in mxs_mmc_host
  mmc: mxs-mmc: copy wp_gpio in struct mxs_mmc_host
  mmc: mxs-mmc: add device tree support
  ARM: dts: enable mmc for imx23-evk
  ARM: dts: enable mmc for imx28-evk

 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |   26 +++
 arch/arm/boot/dts/imx23-evk.dts                    |   11 +
 arch/arm/boot/dts/imx23.dtsi                       |   19 ++
 arch/arm/boot/dts/imx28-evk.dts                    |   19 ++
 arch/arm/boot/dts/imx28.dtsi                       |   25 +++
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c       |   21 +-
 arch/arm/mach-mxs/include/mach/devices-common.h    |    3 +-
 drivers/clk/mxs/clk-imx23.c                        |    4 +-
 drivers/clk/mxs/clk-imx28.c                        |    8 +-
 drivers/mmc/host/mxs-mmc.c                         |  199 +++++++++++---------
 .../mach/mmc.h => include/linux/mmc/mxs-mmc.h      |    7 +-
 11 files changed, 235 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
 rename arch/arm/mach-mxs/include/mach/mmc.h => include/linux/mmc/mxs-mmc.h (81%)

-- 
1.7.5.4
