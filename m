From: olof@lixom.net (Olof Johansson)
Date: Sat, 1 Sep 2018 19:36:03 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180902023603.2krvellhztpkoj67@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to a72b44a871c218e2a0580e68affa1d3528c0587a:

  Merge tag 'omap-for-v4.19/fixes-v2-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-09-01 18:22:19 -0700)

----------------------------------------------------------------
ARM: SoC fixes

First batch of fixes post-merge window:

 - A handful of devicetree changes for i.MX2{3,8} to change over to new
   panel bindings. The platforms were moved from legacy framebuffers
   to DRM and some development board panels hadn't yet been converted.
 - OMAP fixes related to ti-sysc driver conversion fallout, fixing some
   register offsets, no_console_suspend fixes, etc.
 - Droid4 changes to fix flaky eMMC probing and vibrator DTS mismerge.
 - Fixed 0755->0644 permissions on a newly added file.
 - Defconfig changes to make ARM Versatile more useful with QEMU
   (helps testing).
 - Enable defconfig options for new TI SoC platform that was merged this
   window (AM6).

----------------------------------------------------------------
Fabio Estevam (6):
      ARM: dts: imx28-evk: Move regulators outside simple-bus
      ARM: dts: imx28-evk: Convert to the new display bindings
      ARM: dts: imx23-evk: Move regulators outside simple-bus
      ARM: dts: imx23-evk: Convert to the new display bindings
      ARM: mxs_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G
      ARM: imx_v6_v7_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G

Keerthy (1):
      arm: dts: am4372: setup rtc as system-power-controller

Leonard Crestez (1):
      Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"

Linus Walleij (1):
      ARM: defconfig: Update the ARM Versatile defconfig

Neeraj Dantu (1):
      ARM: dts: Fix file permission for am335x-osd3358-sm-red.dts

Nishanth Menon (1):
      arm64: defconfig: Enable TI's AM6 SoC platform

Olof Johansson (2):
      Merge tag 'imx-fixes-4.19' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.19/fixes-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix vibrations on Droid 4

Tony Lindgren (6):
      ARM: OMAP2+: Fix null hwmod for ti-sysc debug
      ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
      bus: ti-sysc: Fix module register ioremap for larger offsets
      bus: ti-sysc: Fix no_console_suspend handling
      Merge branch 'perm-fix' into omap-for-v4.19/fixes-v2
      ARM: dts: omap4-droid4: Fix emmc errors seen on some devices

 arch/arm/boot/dts/am335x-osd3358-sm-red.dts |   0
 arch/arm/boot/dts/am4372.dtsi               |   1 +
 arch/arm/boot/dts/imx23-evk.dts             |  90 +++++++-------
 arch/arm/boot/dts/imx28-evk.dts             | 183 +++++++++++++---------------
 arch/arm/boot/dts/imx7d.dtsi                |  12 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts    |  20 +--
 arch/arm/configs/imx_v6_v7_defconfig        |   1 +
 arch/arm/configs/mxs_defconfig              |   1 +
 arch/arm/configs/versatile_defconfig        |  14 ++-
 arch/arm/mach-omap2/omap_hwmod.c            |  39 +++++-
 arch/arm64/configs/defconfig                |   3 +
 drivers/bus/ti-sysc.c                       |  37 +++---
 12 files changed, 213 insertions(+), 188 deletions(-)
 mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
