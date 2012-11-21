From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Nov 2012 10:12:13 +0100
Subject: [GIT PULL] ARM: sunxi: support for sun4i (A10) SoCs
Message-ID: <1353489133-25814-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is a pull request to add the support for Allwinner A10 SoCs.

Thanks,
Maxime

The following changes since commit 1b106699647b56313bac707e12e7ad67180cb147:

  ARM: sunxi: Add entry to MAINTAINERS (2012-11-16 21:56:53 +0100)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/tags/sun4i-support-for-3.8

for you to fetch changes up to 67bea88dd842deb3ed8327ad101970dbd615ddcb:

  ARM: sunxi: Add sunxi restart function via onchip watchdog (2012-11-21 09:25:25 +0100)

----------------------------------------------------------------
Add support for sun4i (A10) SoCs and the cubieboard

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sunxi: Add sunxi restart function via onchip watchdog

Stefan Roese (3):
      ARM: sunxi: Restructure sunxi dts/dtsi files
      ARM: sunxi: Add earlyprintk support for UART0 (sun4i)
      ARM: sunxi: Add sun4i and cubieboard support

 .../devicetree/bindings/watchdog/sunxi-wdt.txt     |   13 ++++
 arch/arm/Kconfig.debug                             |    9 ++-
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/sun4i-cubieboard.dts             |   38 ++++++++++
 arch/arm/boot/dts/sun5i-olinuxino.dts              |    6 +-
 arch/arm/boot/dts/sun5i.dtsi                       |   56 +-------------
 arch/arm/boot/dts/sunxi.dtsi                       |   80 ++++++++++++++++++++
 arch/arm/include/debug/sunxi.S                     |    5 +-
 arch/arm/mach-sunxi/sunxi.c                        |   35 +++++++++
 9 files changed, 186 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
 create mode 100644 arch/arm/boot/dts/sun4i-cubieboard.dts
 create mode 100644 arch/arm/boot/dts/sunxi.dtsi
