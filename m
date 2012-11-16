From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Nov 2012 16:03:04 +0800
Subject: [GIT PULL] mxs changes for 3.8
Message-ID: <20121116080302.GG2941@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.8

for you to fetch changes up to 4e556c046df2bd8d6eef6403c25bf8e52f64be93:

  ARM: mxs_defconfig: Improve USB related support (2012-11-16 15:11:32 +0800)

----------------------------------------------------------------
It's mxs device tree changes for 3.8.  The majority is device tree
source updates.  One timer improvement and one defconfig update are
also included there.

----------------------------------------------------------------
Fabio Estevam (4):
      ARM: dts: imx28-evk: Use pinctrl for gpio-led
      ARM: dts: imx23-olinuxino: Remove unneeded "default-on"
      ARM: dts: imx23-olinuxino: Use pinctrl for gpio-led
      ARM: mxs_defconfig: Improve USB related support

Gwenhael Goavec-Merou (5):
      ARM: mxs: Add support for the Armadeus Systems APF28Dev docking board
      ARM: dts: mxs: Add 16 bits LCD screen muxing options for I.MX28
      ARM: mxs: apf28dev: Add pinctrl and gpios
      ARM: mxs: apf28dev: Add LCD and backlight support
      ARM: mxs: apf28dev: Add I2C and SPI support

Julien Boibessot (2):
      ARM: mxs: Add support for the Armadeus Systems APF28 module
      ARM: dts: mxs: Add PWM3 muxing options for i.MX28

Marek Vasut (1):
      ARM: mx28: Skip OCOTP FEC MAC setup if in DT

Maxime Ripard (4):
      ARM: dts: cfa10049: Add FEC to the CFA-10049 expansion board
      ARM: dts: cfa10049: Add the DH2228FV DAC to the DTS
      ARM: dts: cfa10036: Use pinctrl for power led
      ARM: dts: mxs: Add hog pins to Crystalfontz boards

Stanislav Meduna (1):
      ARM: mxs: Setup scheduler clock

 arch/arm/boot/dts/Makefile            |    2 +
 arch/arm/boot/dts/imx23-olinuxino.dts |   14 ++-
 arch/arm/boot/dts/imx28-apf28.dts     |   85 ++++++++++++++++++
 arch/arm/boot/dts/imx28-apf28dev.dts  |  154 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-cfa10036.dts  |   27 ++++++
 arch/arm/boot/dts/imx28-cfa10049.dts  |   33 +++++++
 arch/arm/boot/dts/imx28-evk.dts       |   13 ++-
 arch/arm/boot/dts/imx28.dtsi          |   35 ++++++++
 arch/arm/configs/mxs_defconfig        |    6 ++
 arch/arm/mach-mxs/mach-mxs.c          |   49 +++++++++++
 arch/arm/mach-mxs/timer.c             |   10 ++-
 11 files changed, 424 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-apf28.dts
 create mode 100644 arch/arm/boot/dts/imx28-apf28dev.dts
