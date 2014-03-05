From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 13:06:34 +0800
Subject: [GIT PULL] ARM: imx: device tree changes for 3.15, take 2
Message-ID: <20140305050632.GA23980@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second round of imx device tree changes for 3.15, which is
based on the first round pull request - tag imx-dt-3.15.  Please pull,
thanks.

Shawn

The following changes since commit ee97d154f0a81f87f0f88c99a3963da2ab5ad787:

  ARM: dts: imx28-m28cu3: Remove 'reset-active-high' (2014-02-09 21:33:52 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.15-2

for you to fetch changes up to b4e5e84ddfc57fa269fa50d178ad95d49be33a28:

  ARM: dts: vf610: i2c: Add eDMA support (2014-02-27 20:33:33 +0800)

----------------------------------------------------------------
i.MX device tree changes for 3.15, take 2:
 - Cleanup and device additions for imx27-phytec-phycard boards
 - eDMA and audio support for vf610-twr board
 - Minor updates and fixes for a couple of imx28 and imx5 boards

----------------------------------------------------------------
Alexander Shiyan (8):
      ARM: dts: imx27-phytec-phycard-s-som: Sort entries
      ARM: dts: imx27-phytec-phycard-s-som: Add NFC node
      ARM: dts: imx27-phytec-phycard-s-rdk: Add pinctrl definitions for SDHC2
      ARM: dts: imx27-phytec-phycard-s-som: Rename file to .dtsi
      ARM: dts: imx27-phytec-phycore: Add diagnostic PMIC LEDs
      ARM: dts: i.MX27: Add USB nodes
      ARM: dts: imx27-phytec-phycore-rdk: Add USBH2 node
      ARM: dts: imx27-phytec-phycore-som: Add USBOTG node

Fabio Estevam (2):
      ARM: dts: mx53: Remove 'enable-active-low' property
      ARM: dts: imx28-tx28: Remove 'enable-active-low' property

Fugang Duan (1):
      ARM: dts: vf610-twr: Add ADC support

Jingchang Lu (1):
      ARM: dts: vf610: Add eDMA node

Liu Ying (1):
      ARM: dts: i.MX51 babbage: Support diagnostic LED

Marek Vasut (1):
      ARM: dts: mxs: Fix the RTC compatible prop on M28EVK

Xiubo Li (4):
      ARM: dts: vf610: Add edma mux Tx and Rx support for SAI node.
      ARM: dts: vf610-twr: Enable SAI ALSA SoC DAI device
      ARM: dts: vf610-twr: Enable SGTL5000 codec.
      ARM: dts: vf610-twr: Add simple-card support.

Yuan Yao (2):
      ARM: dts: vf610: lpuart: Add eDMA support
      ARM: dts: vf610: i2c: Add eDMA support

 arch/arm/boot/dts/Makefile                         |    1 -
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   16 +++-
 ...d-s-som.dts => imx27-phytec-phycard-s-som.dtsi} |   49 ++++++++---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   81 +++++++++++++++++
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   44 ++++++++++
 arch/arm/boot/dts/imx27.dtsi                       |   56 ++++++++++++
 arch/arm/boot/dts/imx28-m28evk.dts                 |    2 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |    1 -
 arch/arm/boot/dts/imx51-babbage.dts                |   17 ++++
 arch/arm/boot/dts/imx53-m53evk.dts                 |    1 -
 arch/arm/boot/dts/imx53-mba53.dts                  |    1 -
 arch/arm/boot/dts/imx53-tx53.dtsi                  |    1 -
 arch/arm/boot/dts/vf610-twr.dts                    |   92 ++++++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi                       |   66 ++++++++++++++
 14 files changed, 407 insertions(+), 21 deletions(-)
 rename arch/arm/boot/dts/{imx27-phytec-phycard-s-som.dts => imx27-phytec-phycard-s-som.dtsi} (81%)
