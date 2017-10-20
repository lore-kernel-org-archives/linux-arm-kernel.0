From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Oct 2017 23:29:00 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.14
Message-ID: <CAK8P3a06kKXafxcxLCQRCBSt1tMvgkXuBafKoPD=Qvt0r=v8qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to 6bf99a6cb69f78de0083b76a7c033918f853f580:

  Merge tag 'sunxi-fixes-for-4.14' of
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into fixes
(2017-10-20 22:24:48 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.14

Here is another set of bugfixes for ARM SoCs, mostly harmless:

 - A boot regression fix on ux500
 - PCIe interrupts on NXP i.MX7 and on Marvell Armada 7K/8K were
   wired up wrong, in different ways
 - Armada XP support for large memory never worked
 - The socfpga reset controller now builds on 64-bit
 - minor device tree corrections on gemini, mvebu, r-pi 3,
   rockchip and at91

----------------------------------------------------------------
Andrey Smirnov (1):
      ARM: dts: imx7d: Invert legacy PCI irq mapping

Arnd Bergmann (9):
      arm64: dts: rockchip: fix typo in iommu nodes
      Merge tag 'arm-soc/for-4.14/devicetree-fixes' of
http://github.com/Broadcom/stblinux into fixes
      Merge tag 'at91-fixes2' of
git://git.kernel.org/.../nferre/linux-at91 into fixes
      Merge tag 'mvebu-fixes-4.14-2' of
git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'imx-fixes-4.14' of
git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'v4.14-rockchip-dts64fixes-2' of
git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'reset-fixes-for-4.14-2' of
git://git.pengutronix.de/git/pza/linux into fixes
      Merge tag 'renesas-fixes-for-v4.14' of
https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'sunxi-fixes-for-4.14' of
https://git.kernel.org/.../sunxi/linux into fixes

Chen-Yu Tsai (1):
      ARM: dts: sun6i: Fix endpoint IDs in second display pipeline

Dinh Nguyen (1):
      reset: socfpga: fix for 64-bit compilation

Eugen Hristev (2):
      ARM: dts: at91: sama5d2_xplained: enable ADTRG pin
      ARM: dts: at91: sama5d2: add ADC hw trigger edge type

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-fixes-2017-10-06' into devicetree/fixes

Jagan Teki (1):
      arm64: allwinner: a64: pine64: Use dcdc1 regulator for mmc0

Jan Luebbe (1):
      bus: mbus: fix window size calculation for 4GB windows

Kalyan Kinthada (1):
      ARM: dts: Fix I2C repeated start issue on Armada-38x

Linus Walleij (1):
      ARM: dts: fix PCLK name on Gemini and MOXA ART

Loic Poulain (1):
      ARM: dts: bcm283x: Fix console path on RPi3

Ludovic Desroches (1):
      ARM: dts: at91: at91-sama5d27_som1: fix PHY ID

Shawn Lin (1):
      arm64: dts: rockchip: correct vqmmc voltage for rk3399 platforms

Thomas Petazzoni (1):
      arm64: dts: marvell: fix interrupt-map property for Armada CP110
PCIe controller

Ulf Hansson (1):
      ARM: ux500: Fix regression while init PM domains

Ulrich Hecht (1):
      arm64: dts: salvator-common: add 12V regulator to backlight

 arch/arm/boot/dts/armada-38x.dtsi                    |  4 ++--
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi            |  4 ++--
 arch/arm/boot/dts/at91-sama5d2_xplained.dts          | 16 +++++++++++++++-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts             |  9 +++------
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts                |  5 +++++
 arch/arm/boot/dts/bcm283x.dtsi                       |  7 ++++++-
 arch/arm/boot/dts/gemini.dtsi                        |  3 ++-
 arch/arm/boot/dts/imx7d.dtsi                         |  8 ++++----
 arch/arm/boot/dts/moxart.dtsi                        |  3 ++-
 arch/arm/boot/dts/sama5d2.dtsi                       |  1 +
 arch/arm/boot/dts/sun6i-a31.dtsi                     | 16 ++++++++--------
 arch/arm/mach-ux500/cpu-db8500.c                     |  4 ++++
 arch/arm/mach-ux500/pm.c                             |  4 ----
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts  |  9 +--------
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi |  6 +++---
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  6 +++---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi     | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi             |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi             |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi        |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi    |  4 ++--
 drivers/bus/mvebu-mbus.c                             |  2 +-
 drivers/reset/reset-socfpga.c                        | 17 ++++++++++-------
 include/linux/mbus.h                                 |  4 ++--
 25 files changed, 92 insertions(+), 62 deletions(-)
