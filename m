From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Dec 2017 21:11:05 -0800
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20171210051105.ycd4xm2jyhyycbhr@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 8be0b9886b6470a1261c9c2d0cfc1f0f89bf21b9:

  Merge branch 'fixes' into for-next (2017-12-09 20:23:58 -0800)

----------------------------------------------------------------
ARM: SoC fixes for 4.15-rc

ARM SoC fixes for this merge window:

 - A revert of all SCPI changes from the 4.15 merge window. They had
   regressions on the Amlogic platforms, and the submaintainer isn't
   around to fix these bugs due to vacation, etc. So we agreed to revert
   and revisit in next release cycle.

 - A series fixing a number of bugs for ARM CCN interconnect, around
   module unload, smp_processor_id() in preemptable context, and fixing
   some memory allocation failure checks.

 - A handful of devicetree fixes for different platforms, fixing
   warnings and errors that were previously ignored by the compiler.

 - The usual set of mostly minor fixes for different platforms.

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: logicpd-som-lv: Fix gpmc addresses for NAND and enet
      ARM: dts: logicpd-somlv: Fix wl127x pinmux

Arnaud Patard (1):
      meson-gx-socinfo: Fix package id parsing

Arnd Bergmann (3):
      ARM: dts: r8a779x: Add '#reset-cells' in cpg-mssr
      ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds
      Merge branch 'fixes' into for-next

Arvind Yadav (1):
      bus: arm-ccn: constify attribute_group structures.

Christophe JAILLET (2):
      bus: arm-ccn: Check memory allocation failure
      bus: arm-ccn: Simplify code

Colin Ian King (1):
      ARM: meson: fix spelling mistake: "Couln't" -> "Couldn't"

Dai Okamura (1):
      arm64: dts: uniphier: correct on-board device IRQ number for PXs3

Dan Carpenter (1):
      ARM: OMAP2+: Missing error code in omap_device_build()

Fabio Estevam (2):
      ARM: dts: vf610-zii-dev-rev-c: Fix the I2C EEPROM address
      Revert "ARM: dts: imx53: add srtc node"

Florian Fainelli (3):
      ARM: dts: NSP: Disable AHCI controller for HR NSP boards
      ARM: dts: NSP: Fix PPI interrupt types
      Merge tag 'bcm2835-dt-next-fixes-2017-11-15' into devicetree/fixes

Jens Wiklander (1):
      optee: fix invalid of_node_put() in optee_driver_init()

Keerthy (1):
      ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function

Kim Phillips (1):
      bus: arm-ccn: fix module unloading Error: Removing state 147 which has instances left.

Marc Zyngier (2):
      bus: arm-ccn: Fix use of smp_processor_id() in preemptible context
      bus: arm-cci: Fix use of smp_processor_id() in preemptible context

Martin Blumenstingl (2):
      ARM: dts: meson: correct the sort order for the the gpio_intc node
      ARM: dts: meson: fix the memory region of the GPIO interrupt controller

Masahiro Yamada (3):
      arm64: dts: uniphier: remove unnecessary interrupt-parent
      MAINTAINERS: exclude other Socionext SoC DT files from ARM/UNIPHIER entry
      arm64: dts: sort vendor subdirectories in Makefile alphabetically

Neil Armstrong (1):
      ARM64: dts: meson-gx: fix UART pclk clock name

Olof Johansson (12):
      Merge tag 'renesas-dt-fixes-for-v4.15' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'arm-soc/for-4.15/devicetree-fixes-1' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'tee-drv-fix-for-4.15' of https://git.linaro.org/people/jens.wiklander/linux-tee into fixes
      Merge tag 'uniphier-fixes-v4.15' of git://git.kernel.org/.../masahiroy/linux-uniphier into fixes
      Merge tag 'imx-fixes-4.15' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.15/fixes-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      firmware: arm_scpi: Revert updates made during v4.15 merge window
      Merge branch 'fixes' into for-next
      Merge tag 'omap-for-v4.15/fixes-dt-warnings' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'ccn/fixes-for-4.15' of git://git.linaro.org/people/pawel.moll/linux into fixes
      Merge tag 'amlogic-fixes-1' of git://git.kernel.org/.../khilman/linux-amlogic into fixes
      Merge branch 'fixes' into for-next

Peter Ujfalusi (2):
      ARM: dts: am4372: Correct the interrupts_properties of McASP
      ARM: dts: am437x-cm-t43: Correct the dmas property of spi0

Rob Herring (4):
      ARM: dts: omap: Add missing #phy-cells to usb-nop-xceiv
      ARM: dts: am33xx: Add missing #phy-cells to ti,am335x-usb-phy
      arm: dts: marvell: Add missing #phy-cells to usb-nop-xceiv
      arm: dts: nspire: Add missing #phy-cells to usb-nop-xceiv

Stefan Wahren (1):
      ARM: dts: bcm283x: Fix DTC warnings about missing phy-cells

Tero Kristo (2):
      ARM: OMAP3: hwmod_data: add missing module_offs for MMC3
      ARM: OMAP2/3: CM: fix cm_split_idlest functionality

Tony Lindgren (10):
      ARM: OMAP2+: Fix smatch found issue for omap_device
      ARM: dts: Add remote-wakeup-connected for omap OHCI
      ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context
      ARM: dts: Fix omap4 hang with GPS connected to USB by using wakeupgen
      Merge branch 'soc-fixes' into omap-for-v4.15/fixes
      Merge branch 'dts-fixes' into omap-for-v4.15/fixes-dt
      Merge branch 'omap-for-v4.14/fixes' into omap-for-v4.15/fixes-v2
      Merge branch 'omap-for-v4.15/fixes-dt' into omap-for-v4.15/fixes-v2
      ARM: dts: Fix elm interrupt compiler warning
      ARM: dts: Fix dm814x missing phy-cells property

 .../devicetree/bindings/usb/am33xx-usb.txt         |   2 +
 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +
 arch/arm/boot/dts/am4372.dtsi                      |   6 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                |   4 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |   1 +
 arch/arm/boot/dts/armada-385-linksys.dtsi          |   1 +
 arch/arm/boot/dts/armada-385-synology-ds116.dts    |   2 +
 arch/arm/boot/dts/armada-388-gp.dts                |   2 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   4 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |   1 +
 arch/arm/boot/dts/bcm958623hr.dts                  |   4 -
 arch/arm/boot/dts/bcm958625hr.dts                  |   4 -
 arch/arm/boot/dts/dm814x.dtsi                      |   2 +
 arch/arm/boot/dts/imx53.dtsi                       |   9 -
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   |   3 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  17 +-
 arch/arm/boot/dts/meson.dtsi                       |  18 +-
 arch/arm/boot/dts/nspire.dtsi                      |   1 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   1 +
 arch/arm/boot/dts/omap3-beagle.dts                 |   1 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +
 arch/arm/boot/dts/omap3-evm-common.dtsi            |   1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   1 +
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       |   1 +
 arch/arm/boot/dts/omap3-igep0030-common.dtsi       |   1 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   1 +
 arch/arm/boot/dts/omap3-overo-base.dtsi            |   1 +
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   1 +
 arch/arm/boot/dts/omap3-tao3530.dtsi               |   1 +
 arch/arm/boot/dts/omap3.dtsi                       |   1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   1 +
 arch/arm/boot/dts/omap4-duovero.dtsi               |   1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   1 +
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   1 +
 arch/arm/boot/dts/omap4.dtsi                       |   5 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |   2 +
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +
 arch/arm/boot/dts/omap5.dtsi                       |   1 +
 arch/arm/boot/dts/r8a7790.dtsi                     |   1 +
 arch/arm/boot/dts/r8a7792.dtsi                     |   1 +
 arch/arm/boot/dts/r8a7793.dtsi                     |   1 +
 arch/arm/boot/dts/r8a7794.dtsi                     |   1 +
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |   2 +-
 arch/arm/mach-meson/platsmp.c                      |   2 +-
 arch/arm/mach-omap2/cm_common.c                    |   6 +-
 arch/arm/mach-omap2/omap-secure.c                  |  21 ++
 arch/arm/mach-omap2/omap-secure.h                  |   4 +
 arch/arm/mach-omap2/omap_device.c                  |  10 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   1 +
 arch/arm/mach-omap2/pm.h                           |   4 -
 arch/arm/mach-omap2/pm34xx.c                       |  13 +-
 arch/arm/mach-omap2/prcm-common.h                  |   1 +
 arch/arm/mach-omap2/prm33xx.c                      |  12 --
 arch/arm/mach-omap2/sleep34xx.S                    |  26 +--
 arch/arm64/boot/dts/Makefile                       |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   6 +-
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts |   1 -
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |   1 -
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   3 +-
 drivers/bus/arm-cci.c                              |   7 +-
 drivers/bus/arm-ccn.c                              |  25 ++-
 drivers/firmware/arm_scpi.c                        | 216 ++++++++++++---------
 drivers/soc/amlogic/meson-gx-socinfo.c             |   4 +-
 drivers/tee/optee/core.c                           |   1 -
 66 files changed, 278 insertions(+), 210 deletions(-)
