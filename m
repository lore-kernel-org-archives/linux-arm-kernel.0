From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:16 -0700
Subject: [GIT PULL 9/9] ARM: SoC late changes for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-10-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were expecting to sit on this branch through most of the merge window since
the contents was merged into our tree late, but we ended up sitting on all of
our contents so it can go in with the rest.

The contents here is:

- A large branch of cleanups of the CM/PRM blocks on OMAP.
- A couple of patches plumbing up CM/PRM on OMAP5 and DRA7.
- A branch with DT updates for Freescale i.MX. including some shuffling from
.dts to .dtsi (include) files that causes a little churn.


Conflicts: None

----------------------------------------------------------------

The following changes since commit bf1fba966c00c89af9a34cad7a546e58350d2d93:

  Merge tag 'armsoc-arm64' into testmerge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to 48c1078509b47b38802329028ccfd77783bcff99:

  Merge tag 'omap-for-v4.1/prcm-dts-mfd-syscon-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/late

----------------------------------------------------------------

Arnd Bergmann (3):
      Merge tag 'omap-for-v4.1/prcm-dts' of git://git.kernel.org/.../tmlind/linux-omap into next/late
      Merge tag 'imx-dt-4.1' of git://git.kernel.org/.../shawnguo/linux into next/late
      Merge branch 'omap/dt' into next/late

Bhuvanchandra DV (2):
      ARM: vf610: add second DSPI instance
      ARM: vf-colibri: add SPI support and enable MCP2515 CAN

Fabio Estevam (5):
      ARM: dts: imx25-pdk: Add LCD support
      ARM: dts: imx6sl-warp: Pass 'bus-width' property
      ARM: dts: imx6sl-warp: Add BCM4330 support
      ARM: dts: imx6sl: Add label snvs_rtc
      ARM: dts: imx6sx: Add label snvs_rtc

George Joseph (1):
      ARM: dts: cubox: Map gpio-keys to gpio3 8

Gwenhael Goavec-Merou (7):
      ARM: dts: imx28-apf28dev: Add pinctrl for USB OTG ID pin
      ARM: dts: imx28-apf28: fix mac0 gpio polarity
      ARM: dts: imx28-apf28dev: fix mac1 gpio location and polarity
      ARM: dts: imx28-apf28dev: add support for can0
      ARM: dts: imx28-apf28dev: add support for auart0
      ARM: dts: imx28-apf28dev: fix user button polarity
      ARM: dts: imx28-apf28dev: add wakeup function to user button

Liu Ying (1):
      ARM: dts: imx6qdl: Move existing MIPI DSI ports into a new 'ports' node

Marc Zyngier (3):
      ARM: imx6: convert GPC to stacked domains
      ARM: imx6: Allow GPC interrupts affinity to be changed
      ARM: imx6: Warn when an old DT is detected

Markus Pargmann (3):
      ARM: dts: imx6qdl: Add label snvs_rtc
      ARM: dts: imx25-pinfunc: remove input values for pinfuncs without input register
      ARM: dts: imx25-pinfunc: Add several pinfunctions

Matt Porter (1):
      ARM: dts: imx: Add dr_mode host setting to all host-only usb instances

Olof Johansson (1):
      Merge tag 'omap-for-v4.1/prcm-dts-mfd-syscon-fix' of git://git.kernel.org/.../tmlind/linux-omap into next/late

Otavio Salvador (1):
      ARM: dts: warp: Add initial WaRP Board support

Peter Chen (3):
      ARM: imx6sx-sdb: change default board as reva board
      ARM: imx6sx-sdb: add revb board and make it default
      ARM: imx6qdl-sabreauto.dtsi: add max7310 support

Philipp Zabel (6):
      ARM: dts: imx6qdl: Add power-domain information to gpc node
      ARM: dts: imx6sl: Add power-domain information to gpc node
      ARM: dts: imx6qdl: Allow disabling the PU regulator, add a enable ramp delay
      ARM: dts: imx6dl-aristainetos: enable backlight PWM explicitly
      ARM: dts: hummingboard/cubox-i: enable front LED PWM explicitly
      ARM: dts: imx6qdl: disable PWMs by default

Rabeeh Khoury (1):
      ARM: dts: hummingboard: Setup pwm lines

Russell King (3):
      ARM: dts: Re-license SolidRun iMX6 platform DT GPL v2/X11
      ARM: dts: hummingboard: enable PCF8523 RTC support
      ARM: dts: hummingboard: add sgtl5000 support for Hummingboard Pro

Shawn Guo (2):
      Merge branch 'imx/soc' into imx/dt
      Merge remote-tracking branch 'jcooper/irqchip/vybrid' into imx/dt

Stefan Agner (3):
      ARM: dts: vf610: remove unused gpio-range-cells property
      ARM: dts: vf610: add Miscellaneous System Control Module (MSCM)
      ARM: dts: vf610: fix missing irqs

Tero Kristo (34):
      ARM: OMAP2+: PRCM: rename of_prcm_init to omap_prcm_init
      ARM: OMAP3: PRM: invert the wkst_mask for the prm_clear_mod_irqs
      ARM: OMAP2+: PRM: add generic API for clear_mod_irqs
      ARM: OMAP3+: PRM: add common APIs for prm_vp_check/clear_txdone
      ARM: OMAP4+: PRM: move omap_prm_base_init under OMAP4 PRM driver
      ARM: OMAP4+: CM: move omap_cm_base_init under OMAP4 CM driver
      ARM: OMAP4: PRM: move omap4xxx_prm_init earlier in init order
      Documentation: DT: document PRCM compatible strings for dm81x SoCs
      ARM: OMAP2+: PRCM: add support for static clock memmap indices
      ARM: OMAP2+: clock: move clock provider infrastructure to clock driver
      ARM: OMAP2+: PRCM: split PRCM module init to their own driver files
      ARM: OMAP2+: CM: determine CM base address from device tree
      ARM: OMAP2+: PRM: determine PRM base address from device tree
      ARM: OMAP2+: control: determine control module base address from DT
      ARM: OMAP2+: PRM: move SoC specific init calls within a generic API
      ARM: OMAP4+: PRM: determine prm_device_inst based on DT compatibility
      ARM: OMAP2+: CM: move SoC specific init calls within a generic API
      ARM: OMAP4+: PRM: setup prm_features from the PRM init time flags
      ARM: OMAP4+: PRM: get rid of cpu_is_omap44xx calls from interrupt init
      ARM: OMAP2+: clock: add low-level support for regmap
      ARM: OMAP2+: control: remove API for getting control module base address
      ARM: OMAP2+: id: cache omap_type value
      ARM: OMAP2+: control: add syscon support for register accesses
      ARM: dts: omap24xx: add minimal l4 bus layout with control module support
      ARM: dts: omap3: add minimal l4 bus layout with control module support
      ARM: dts: am33xx: add minimal l4 bus layout with control module support
      ARM: dts: am43xx-epos-evm: fix pinmux node layout
      ARM: dts: am4372: add minimal l4 bus layout with control module support
      ARM: dts: omap4: add minimal l4 bus layout with control module support
      ARM: OMAP4: display: convert display to use syscon for dsi muxing
      ARM: OMAP4+: control: remove support for legacy pad read/write
      ARM: dts: omap5: add minimal l4 bus layout with control module support
      ARM: dts: dra7: add minimal l4 bus layout with control module support
      ARM: OMAP4+: control: add support for initializing control module via DT

Tony Lindgren (2):
      Merge branch '4.0-rc1-prcm-cleanup-v6' of https://github.com/t-kristo/linux-pm into omap-for-v4.1/prcm-cleanup
      ARM: OMAP2+: Fix booting with configs that don't have MFD_SYSCON

Uwe Kleine-K?nig (3):
      ARM: imx25: fix some wrong iomux definitions
      ARM: dts: imx25-pinfunc: more defines
      ARM: dts: imx28: add alternative pinmuxing for spi3


 .../devicetree/bindings/arm/omap/ctrl.txt       |  79 +++
 .../devicetree/bindings/arm/omap/l4.txt         |  26 +
 .../devicetree/bindings/arm/omap/prcm.txt       |   6 +-
 arch/arm/boot/dts/Makefile                      |   4 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi            |   2 +-
 arch/arm/boot/dts/am33xx.dtsi                   |  87 +--
 arch/arm/boot/dts/am3517.dtsi                   |   2 +-
 arch/arm/boot/dts/am35xx-clocks.dtsi            |   2 +-
 arch/arm/boot/dts/am4372.dtsi                   |  85 +--
 arch/arm/boot/dts/am43x-epos-evm.dts            |  84 +--
 arch/arm/boot/dts/am43xx-clocks.dtsi            |   2 +-
 arch/arm/boot/dts/dra7.dtsi                     | 156 +++--
 arch/arm/boot/dts/imx25-pdk.dts                 |  58 ++
 arch/arm/boot/dts/imx25-pinfunc.h               |  86 ++-
 arch/arm/boot/dts/imx27.dtsi                    |   2 +
 arch/arm/boot/dts/imx28-apf28.dts               |   2 +-
 arch/arm/boot/dts/imx28-apf28dev.dts            |  30 +-
 arch/arm/boot/dts/imx28.dtsi                    |  14 +
 arch/arm/boot/dts/imx35.dtsi                    |   1 +
 arch/arm/boot/dts/imx50.dtsi                    |   3 +
 arch/arm/boot/dts/imx51.dtsi                    |   3 +
 arch/arm/boot/dts/imx53.dtsi                    |   3 +
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts     |   4 +
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts     |   4 +
 arch/arm/boot/dts/imx6dl-cubox-i.dts            |  38 ++
 arch/arm/boot/dts/imx6dl-hummingboard.dts       |  38 ++
 arch/arm/boot/dts/imx6q-cubox-i.dts             |  38 ++
 arch/arm/boot/dts/imx6q-hummingboard.dts        |  38 ++
 arch/arm/boot/dts/imx6q.dtsi                    |  20 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi          |  62 ++
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi     | 101 +++-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi  |  38 ++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi         |  38 ++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi        |  35 ++
 arch/arm/boot/dts/imx6qdl.dtsi                  |  49 +-
 arch/arm/boot/dts/imx6sl-warp.dts               | 262 ++++++++
 arch/arm/boot/dts/imx6sl.dtsi                   |  13 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts           | 143 +++++
 arch/arm/boot/dts/imx6sx-sdb.dts                | 603 +------------------
 arch/arm/boot/dts/imx6sx-sdb.dtsi               | 562 +++++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi                   |   9 +-
 arch/arm/boot/dts/omap2420.dtsi                 |  80 ++-
 arch/arm/boot/dts/omap2430-clocks.dtsi          |   8 +-
 arch/arm/boot/dts/omap2430.dtsi                 | 107 ++--
 arch/arm/boot/dts/omap24xx-clocks.dtsi          |   6 +-
 arch/arm/boot/dts/omap3.dtsi                    |  96 +--
 arch/arm/boot/dts/omap34xx.dtsi                 |   2 +-
 arch/arm/boot/dts/omap36xx.dtsi                 |   2 +-
 arch/arm/boot/dts/omap3xxx-clocks.dtsi          |  13 +-
 arch/arm/boot/dts/omap4.dtsi                    | 200 +++---
 arch/arm/boot/dts/omap5.dtsi                    | 182 +++---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi       |  31 +
 arch/arm/boot/dts/vf-colibri.dtsi               |  15 +
 arch/arm/boot/dts/vf500.dtsi                    | 137 +----
 arch/arm/boot/dts/vfxxx.dtsi                    |  64 +-
 arch/arm/mach-imx/common.h                      |   2 +-
 arch/arm/mach-imx/gpc.c                         | 140 ++++-
 arch/arm/mach-imx/mach-imx6q.c                  |   2 +-
 arch/arm/mach-imx/mach-imx6sl.c                 |   2 +-
 arch/arm/mach-imx/mach-imx6sx.c                 |   2 +-
 arch/arm/mach-imx/pm-imx6.c                     |   6 +-
 arch/arm/mach-omap2/Kconfig                     |   1 +
 arch/arm/mach-omap2/clock.c                     | 111 +++-
 arch/arm/mach-omap2/clock.h                     |   8 +-
 arch/arm/mach-omap2/cm.h                        |   2 +
 arch/arm/mach-omap2/cm2xxx.c                    |   2 +-
 arch/arm/mach-omap2/cm2xxx.h                    |   2 +-
 arch/arm/mach-omap2/cm33xx.c                    |   2 +-
 arch/arm/mach-omap2/cm33xx.h                    |   3 +-
 arch/arm/mach-omap2/cm3xxx.c                    |   3 +-
 arch/arm/mach-omap2/cm3xxx.h                    |   2 +-
 arch/arm/mach-omap2/cm44xx.h                    |   3 +-
 arch/arm/mach-omap2/cm_common.c                 | 156 +++++
 arch/arm/mach-omap2/cminst44xx.c                |   6 +-
 arch/arm/mach-omap2/control.c                   | 201 ++++++-
 arch/arm/mach-omap2/control.h                   |  10 +-
 arch/arm/mach-omap2/display.c                   |  15 +-
 arch/arm/mach-omap2/id.c                        |   5 +-
 arch/arm/mach-omap2/io.c                        | 112 ++--
 arch/arm/mach-omap2/pm24xx.c                    |  24 +-
 arch/arm/mach-omap2/pm34xx.c                    |  18 +-
 arch/arm/mach-omap2/prcm-common.h               |  20 +
 arch/arm/mach-omap2/prm.h                       |  27 +-
 arch/arm/mach-omap2/prm2xxx.c                   |   6 +-
 arch/arm/mach-omap2/prm2xxx.h                   |   4 +-
 arch/arm/mach-omap2/prm33xx.c                   |   2 +-
 arch/arm/mach-omap2/prm33xx.h                   |   2 +-
 arch/arm/mach-omap2/prm3xxx.c                   |  20 +-
 arch/arm/mach-omap2/prm3xxx.h                   |   7 +-
 arch/arm/mach-omap2/prm44xx.c                   |  70 +--
 arch/arm/mach-omap2/prm44xx.h                   |   1 -
 arch/arm/mach-omap2/prm44xx_54xx.h              |   8 +-
 arch/arm/mach-omap2/prm54xx.h                   |   1 -
 arch/arm/mach-omap2/prm7xx.h                    |   2 +-
 arch/arm/mach-omap2/prm_common.c                | 258 ++++++--
 arch/arm/mach-omap2/prminst44xx.c               |  18 +-
 arch/arm/mach-omap2/prminst44xx.h               |   1 +
 arch/arm/mach-omap2/vp.h                        |   9 -
 arch/arm/mach-omap2/vp3xxx_data.c               |   4 +-
 arch/arm/mach-omap2/vp44xx_data.c               |   4 +-
 include/linux/clk/ti.h                          |   6 +-
 101 files changed, 3510 insertions(+), 1575 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/l4.txt
 create mode 100644 arch/arm/boot/dts/imx6sl-warp.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-reva.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb.dtsi
