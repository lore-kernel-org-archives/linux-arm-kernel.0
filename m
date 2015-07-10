From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 10 Jul 2015 13:00:04 -0700
Subject: [GIT PULL] ARM: SoC: fixes for v4.2-rc2
Message-ID: <1436558404-13440-1-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 8dfbc0ab3481bb50216c1609bfd1adb0547ef83f:

  Merge tag 'omap-for-v4.2/fixes-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2015-07-09 15:38:16 -0700)

----------------------------------------------------------------
ARM: SoC: fixes for v4.2-rc2

A fairly random colletion of fixes based on -rc1 for OMAP, sunxi and
prima2 as well as a few arm64-specific DT fixes.

This series also includes a late to support a new Allwinner (sunxi)
SoC, but since it's rather simple and isolated to the
platform-specific code, it's included it for this -rc.

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: dts: am4372: Add emif node

Guo Zeng (1):
      ARM: prima2: move to use REGMAP APIs for rtciobrg

Jens Kuske (2):
      Documentation: sunxi: Update Allwinner SoC documentation
      ARM: sunxi: Introduce Allwinner H3 support

Johan Hovold (1):
      Revert "ARM: dts: am335x-boneblack: disable RTC-only sleep"

Kevin Hilman (4):
      Merge tag 'atlas7-pinctrl-dts-for-4.2' of git://git.kernel.org/.../baohua/linux into fixes
      Merge tag 'sirf-iobrg2regmap-for-4.2' of git://git.kernel.org/.../baohua/linux into fixes
      Merge tag 'sunxi-late-for-4.2' of https://git.kernel.org/.../mripard/linux into fixes
      Merge tag 'omap-for-v4.2/fixes-rc1' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Kristina Martsenko (1):
      arm64: dts: add device tree for ARM SMM-A53x2 on LogicTile Express 20MG

Mark Rutland (1):
      arm: dts: vexpress: describe all PMUs in TC2 dts

Maxime Ripard (1):
      ARM: sunxi: Enable simplefb in the defconfig

Nicholas Krause (1):
      ARM: OMAP2+: Remove unnessary return statement from the void function, omap2_show_dma_caps

Roger Quadros (1):
      ARM: dts: am57xx-beagle-x15: Provide supply for usb2_phy2

Sudeep Holla (1):
      arm: dts: vexpress: add missing CCI PMU device node to TC2

Timo Sigurdsson (1):
      ARM: Remove deprecated symbol from defconfig files

Tirumalesh Chalamarla (1):
      GICv3: Add ITS entry to THUNDER dts

Tomi Valkeinen (1):
      ARM: dts: am4372.dtsi: disable rfbi

Tony Lindgren (2):
      memory: omap-gpmc: Fix parsing of devices
      Merge branch 'fixes-rc1' into omap-for-v4.2/fixes

Vishnu Patekar (1):
      ARM: sunxi: Add Machine support for A33

Wei Chen (1):
      ARM: dts: atlas7: add pinctrl and gpio descriptions

Y Vo (1):
      arm64: dts: Add poweroff button device node for APM X-Gene platform

 Documentation/arm/sunxi/README                                   |   18 +-
 Documentation/devicetree/bindings/arm/sunxi.txt                  |    2 +
 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt |    1 +
 MAINTAINERS                                                      |    1 +
 arch/arm/boot/dts/am335x-boneblack.dts                           |    4 +
 arch/arm/boot/dts/am4372.dtsi                                    |    7 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts                          |    4 +
 arch/arm/boot/dts/atlas7.dtsi                                    | 1042 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts                       |   25 +-
 arch/arm/configs/multi_v7_defconfig                              |    1 -
 arch/arm/configs/sunxi_defconfig                                 |    6 +-
 arch/arm/mach-omap2/dma.c                                        |    1 -
 arch/arm/mach-prima2/Kconfig                                     |    1 +
 arch/arm/mach-prima2/rtciobrg.c                                  |   48 ++-
 arch/arm/mach-sunxi/Kconfig                                      |    2 +-
 arch/arm/mach-sunxi/sunxi.c                                      |    5 +-
 arch/arm64/boot/dts/apm/apm-mustang.dts                          |   10 +
 arch/arm64/boot/dts/arm/Makefile                                 |    1 +
 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts             |  191 ++++++++++++
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi                     |    9 +
 drivers/clk/sunxi/clk-sunxi.c                                    |    1 +
 drivers/memory/omap-gpmc.c                                       |    8 +-
 include/linux/rtc/sirfsoc_rtciobrg.h                             |    4 +
 23 files changed, 1373 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
