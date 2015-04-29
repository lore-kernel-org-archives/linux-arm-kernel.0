From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 Apr 2015 22:53:22 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.1
Message-ID: <20150429145321.GA20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.1

for you to fetch changes up to 68ce9a1f24b8e8894955032a4af74998315be9fe:

  ARM: dts: imx6qdl-sabreauto: remove pinctrl-assert-gpios (2015-04-28 09:05:21 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.1:
 - A couple of imx23-olinuxino device tree fixes regarding to LED GPIO
   polarity and USB dr_mode setting
 - One i.MX28 device tree fix on AUART4 TX-DMA interrupt name
 - Add missing pwm-cells to PWM4 for i.MX25 device tree
 - Fix imx6q-phytec device tree to get correct USB VBUS control
 - Drop invalid pinctrl-assert-gpios property from imx6qdl-sabreauto
   device tree, which was sneaked in from vendor device tree
 - One fix on Wolfram's broken email address

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx23-olinuxino: Fix polarity of LED GPIO

Marek Vasut (1):
      ARM: dts: imx28: Fix AUART4 TX-DMA interrupt name

Markus Pargmann (1):
      ARM: dts: imx25: Add #pwm-cells to pwm4

Philipp Zabel (1):
      ARM: dts: imx6: phyFLEX: USB VBUS control is active-high

Shawn Guo (1):
      ARM: dts: imx6qdl-sabreauto: remove pinctrl-assert-gpios

Stefan Wahren (1):
      ARM: dts: imx23-olinuxino: Fix dr_mode of usb0

Wolfram Sang (1):
      ARM: mach-imx: devices: platform-sdhci-esdhc-imx: fix broken email address

 Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt | 2 +-
 arch/arm/boot/dts/imx23-olinuxino.dts                 | 4 +++-
 arch/arm/boot/dts/imx25.dtsi                          | 1 +
 arch/arm/boot/dts/imx28.dtsi                          | 2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi          | 2 ++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi              | 1 -
 arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c  | 2 +-
 7 files changed, 9 insertions(+), 5 deletions(-)
