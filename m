From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Mar 2015 22:02:44 +0800
Subject: [GIT PULL 3/4] ARM: imx: device tree updates for 4.1
Message-ID: <CAAQ0ZWTPqbqk5VwWGQvJ7NbmOy58YOzK4Jv76jEPNL961tpviw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Because of the DT ABI agreement, device tree branch should generally
be able to go alone without any dependencies.  But for this release,
i.MX community have agreed to break the old DTBs to adopt
stacked/hierarchy irq domains for i.MX GPC and Vybrid MSCM controller.
And we included a couple of branches as the merge base for this imx/dt
pull request, including Jason's irqchip/vybrid branch, to resolve some
merge conflicts and maintain the run-time dependency.

Jason,

As we talked, please keep your irqchip/vybrid branch stable.  Thanks.

Shawn


The following changes since commit c5455f708b968dc462a292ba99da0d17100461d8:

  Merge remote-tracking branch 'jcooper/irqchip/vybrid' into imx/dt
(2015-03-30 16:37:21 +0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
tags/imx-dt-4.1

for you to fetch changes up to 8e047c120fb2ccb7b7aba8f5e9224e463f86bebc:

  ARM: dts: hummingboard: add sgtl5000 support for Hummingboard Pro
(2015-03-30 20:57:42 +0800)

----------------------------------------------------------------
The i.MX device tree updates for 4.1:
 - Convert GPC controller to use stacked interrupt domains
 - Add power domain descriptions for i.MX6 platforms
 - Improve i.MX25 pin function defines
 - Disable PWM devices in <soc>.dtsi by default and enable it at board
   level dts where the device is actually available.
 - Define labels for SNVS RTC device to ease the board description,
   where an external RTC is available.
 - Add dr_mode host setting to all i.MX host-only USB instances
 - Support Miscellaneous System Control Module (MSCM) for VF610
 - Add initial i.MX6SL WaRP Board support
 - Add i.MX6SX SDB revision B board support
 - A bunch of imx28-apf28dev board updates, including gpio polarity
   correction and CAN, AUART device support.
 - SolidRun iMX6 platform updates: dual-license of GPLv2/X11, PWM
   setup, PCF8523 RTC, GPIO key and SGTL5000 audio support.
 - A number of random device additions for boards: SPI and CAN for
   vf-colibri, MAX7310 GPIO expander for imx6qdl-sabreauto and LCD
   support for imx25-pdk.

Note: Branch imx/cleanup was merged as the base to solve conflict on
imx25 iomux header.  Branch imx/soc was merged as the base to solve
conflict on arch/arm/mach-imx/gpc.c.  And Jason Cooper's irqchip/vybrid
branch was pulled into the base as a run-time dependency.

----------------------------------------------------------------
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
      ARM: dts: imx25-pinfunc: remove input values for pinfuncs
without input register
      ARM: dts: imx25-pinfunc: Add several pinfunctions

Matt Porter (1):
      ARM: dts: imx: Add dr_mode host setting to all host-only usb instances

Otavio Salvador (1):
      ARM: dts: warp: Add initial WaRP Board support

Peter Chen (3):
      ARM: imx6sx-sdb: change default board as reva board
      ARM: imx6sx-sdb: add revb board and make it default
      ARM: imx6qdl-sabreauto.dtsi: add max7310 support

Philipp Zabel (6):
      ARM: dts: imx6qdl: Add power-domain information to gpc node
      ARM: dts: imx6sl: Add power-domain information to gpc node
      ARM: dts: imx6qdl: Allow disabling the PU regulator, add a
enable ramp delay
      ARM: dts: imx6dl-aristainetos: enable backlight PWM explicitly
      ARM: dts: hummingboard/cubox-i: enable front LED PWM explicitly
      ARM: dts: imx6qdl: disable PWMs by default

Rabeeh Khoury (1):
      ARM: dts: hummingboard: Setup pwm lines

Russell King (3):
      ARM: dts: Re-license SolidRun iMX6 platform DT GPL v2/X11
      ARM: dts: hummingboard: enable PCF8523 RTC support
      ARM: dts: hummingboard: add sgtl5000 support for Hummingboard Pro

Stefan Agner (3):
      ARM: dts: vf610: remove unused gpio-range-cells property
      ARM: dts: vf610: add Miscellaneous System Control Module (MSCM)
      ARM: dts: vf610: fix missing irqs

Uwe Kleine-K?nig (3):
      ARM: imx25: fix some wrong iomux definitions
      ARM: dts: imx25-pinfunc: more defines
      ARM: dts: imx28: add alternative pinmuxing for spi3

 arch/arm/boot/dts/Makefile                     |   4 +-
 arch/arm/boot/dts/imx25-pdk.dts                |  58 +++
 arch/arm/boot/dts/imx25-pinfunc.h              |  86 +++-
 arch/arm/boot/dts/imx27.dtsi                   |   2 +
 arch/arm/boot/dts/imx28-apf28.dts              |   2 +-
 arch/arm/boot/dts/imx28-apf28dev.dts           |  30 +-
 arch/arm/boot/dts/imx28.dtsi                   |  14 +
 arch/arm/boot/dts/imx35.dtsi                   |   1 +
 arch/arm/boot/dts/imx50.dtsi                   |   3 +
 arch/arm/boot/dts/imx51.dtsi                   |   3 +
 arch/arm/boot/dts/imx53.dtsi                   |   3 +
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts    |   4 +
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts    |   4 +
 arch/arm/boot/dts/imx6dl-cubox-i.dts           |  38 ++
 arch/arm/boot/dts/imx6dl-hummingboard.dts      |  38 ++
 arch/arm/boot/dts/imx6q-cubox-i.dts            |  38 ++
 arch/arm/boot/dts/imx6q-hummingboard.dts       |  38 ++
 arch/arm/boot/dts/imx6q.dtsi                   |  20 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi         |  62 +++
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi    | 101 ++++-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi |  38 ++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi        |  38 ++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi       |  35 ++
 arch/arm/boot/dts/imx6qdl.dtsi                 |  49 +-
 arch/arm/boot/dts/imx6sl-warp.dts              | 262 +++++++++++
 arch/arm/boot/dts/imx6sl.dtsi                  |  13 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts          | 143 ++++++
 arch/arm/boot/dts/imx6sx-sdb.dts               | 603 ++-----------------------
 arch/arm/boot/dts/imx6sx-sdb.dtsi              | 562 +++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi                  |   9 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi      |  31 ++
 arch/arm/boot/dts/vf-colibri.dtsi              |  15 +
 arch/arm/boot/dts/vf500.dtsi                   | 137 +-----
 arch/arm/boot/dts/vfxxx.dtsi                   |  64 ++-
 arch/arm/mach-imx/common.h                     |   2 +-
 arch/arm/mach-imx/gpc.c                        | 140 +++++-
 arch/arm/mach-imx/mach-imx6q.c                 |   2 +-
 arch/arm/mach-imx/mach-imx6sl.c                |   2 +-
 arch/arm/mach-imx/mach-imx6sx.c                |   2 +-
 arch/arm/mach-imx/pm-imx6.c                    |   6 +-
 40 files changed, 1913 insertions(+), 789 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6sl-warp.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-reva.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb.dtsi
