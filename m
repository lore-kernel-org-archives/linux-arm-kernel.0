From: tony@atomide.com (Tony Lindgren)
Date: Wed,  7 Jun 2017 05:25:25 -0700
Subject: [GIT PULL 2/2] device tree changes for omaps for v4.13
In-Reply-To: <pull-1496838233-684770>
References: <pull-1496838233-684770>
Message-ID: <pull-1496838233-684770-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/dt-signed

for you to fetch changes up to de09eb52a1cceb6f80464a008c67c7bebb242314:

  arm: dts: am33xx: Remove redundant interrupt-parent property (2017-06-06 00:33:48 -0700)

----------------------------------------------------------------
Device tree changes for omaps for v4.13 merge window.
This adds support for am335x-boneblue. The rest of
the changes are for enabling features on various
devices with the git shortlog describing the changes.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: am335x-phycore-som: fix rv4162 compatible

Fabio Estevam (1):
      ARM: dts: omap3: Remove 'enable-active-low' property

H. Nikolaus Schaller (1):
      ARM: dts: OMAP5: uevm: add ?SD card detect

Javier Martinez Canillas (1):
      ARM: dts: omap: Add generic compatible string for I2C EEPROM

Keerthy (1):
      ARM: dts: AM43XX: Remove min and max voltage values for dcdc3

Marek Belisko (1):
      ARM: dts: twl4030: Add missing madc reference for bci subnode

Peter Ujfalusi (1):
      ARM: dts: am43xx-clocks: Add support for CLKOUT2

Ricardo Salveti (1):
      arm: dts: boneblack-wireless: add WL1835 Bluetooth device node

Robert Nelson (2):
      ARM: dts: Add am335x-boneblue
      ARM: dts: bonegreen-wireless: add WL1835 Bluetooth device node

Roger Quadros (1):
      ARM: dts: dra7x-evm: Enable dual-role mode for USB1

Sebastian Reichel (1):
      ARM: dts: omap4-droid4: Add bluetooth

Suman Anna (2):
      ARM: dts: am572x-idk: Enable the system mailboxes 5 and 6
      ARM: dts: am571x-idk: Enable the system mailboxes 5 and 6

Suniel Mahesh (1):
      arm: dts: am33xx: Remove redundant interrupt-parent property

Tony Lindgren (3):
      ARM: dts: Enable earlycon stdout path for duovero
      ARM: dts: Enable earlycon stdout path for LogicPD torpedo
      ARM: dts: Configure USB host for 37xx-evm

Uwe Kleine-K?nig (1):
      ARM: dts: omap4-devkit8000: fix gpmc ranges property

Viresh Kumar (1):
      ARM: dts: Use - instead of @ for DT OPP entries for TI SoCs

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |  20 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-baltos.dtsi               |   2 +-
 arch/arm/boot/dts/am335x-base0033.dts              |   2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |  10 +-
 arch/arm/boot/dts/am335x-boneblack-wireless.dts    |   5 +
 arch/arm/boot/dts/am335x-boneblack.dts             |   2 +-
 arch/arm/boot/dts/am335x-boneblue.dts              | 460 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts    |   5 +
 arch/arm/boot/dts/am335x-nano.dts                  |   2 +-
 arch/arm/boot/dts/am335x-pepper.dts                |   2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   2 +-
 arch/arm/boot/dts/am335x-shc.dts                   |   2 +-
 arch/arm/boot/dts/am335x-sl50.dts                  |   2 +-
 arch/arm/boot/dts/am33xx.dtsi                      |  26 +-
 arch/arm/boot/dts/am4372.dtsi                      |  10 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   2 -
 arch/arm/boot/dts/am437x-idk-evm.dts               |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |   4 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   4 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               |  36 ++
 arch/arm/boot/dts/am571x-idk.dts                   |  17 +
 arch/arm/boot/dts/am572x-idk.dts                   |  20 +
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   2 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   3 +-
 arch/arm/boot/dts/dra7.dtsi                        |   4 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |   3 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   4 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |   9 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts               | 102 +++++
 arch/arm/boot/dts/omap3-evm-common.dtsi            |  34 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi                |   3 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi               |   1 -
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  20 +
 arch/arm/boot/dts/omap4-duovero.dtsi               |   4 +
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/boot/dts/omap5-sbc-t54.dts                |   2 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |  13 +
 arch/arm/boot/dts/twl4030.dtsi                     |   2 +
 42 files changed, 779 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-boneblue.dts
