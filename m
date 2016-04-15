From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 15 Apr 2016 18:51:01 +0100
Subject: [GIT PULL] ARM: vexpress: Updates for v4.7
Message-ID: <57112A05.3070709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

This time addition of support for Cortex-M based MPS2 system is
the main highlight. I could not split the patches into platform,
driver and DT because it's newly added and have Kconfig/Makefile
dependency.

Please pull !

--
Regards,
Sudeep


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/vexpress-for-v4.7/updates

for you to fetch changes up to d6c4382919935e8354640d994d90f928096da96c:

   ARM: dts: vexpress: Add external expansion bus to DT (2016-04-15 
17:27:55 +0100)

----------------------------------------------------------------
ARMv7 Vexpress updates and fixes for v4.7

1. Basic support for ARM Versatile Express Cortex-M Prototyping System
    (V2M-MPS2). ucLinux can be now run on both the hardware and FVP
    models with Cortex-M3/M4/M7 configurations (Vladimir Murzin)

2. Support for external expansion bus useful for additional hardware
    e.g. LogicTile Express daughterboards (Brian Starkey)

3. Fix for device node name unit-address presence/absence warnings
    enabled in recently update DTC (Sudeep Holla)

----------------------------------------------------------------
Brian Starkey (1):
       ARM: dts: vexpress: Add external expansion bus to DT

Sudeep Holla (1):
       ARM: dts: vexpress: fix node name unit-address presence warnings

Vladimir Murzin (10):
       dt-bindings: document the MPS2 timer bindings
       clockevents/drivers: add MPS2 Timer driver
       dt-bindings: document the MPS2 UART bindings
       serial: mps2-uart: add MPS2 UART driver
       serial: mps2-uart: add support for early console
       ARM: vexpress/mps2: introduce MPS2 platform
       ARM: configs: add MPS2 defconfig
       ARM: dts: introduce MPS2 AN385/AN386
       ARM: dts: introduce MPS2 AN399/AN400
       MAINTAINERS: Update ARM Versatile Express platform entry

  .../devicetree/bindings/serial/arm,mps2-uart.txt   |  19 +
  .../devicetree/bindings/timer/arm,mps2-timer.txt   |  28 +
  MAINTAINERS                                        |   1 +
  arch/arm/Kconfig                                   |  12 +
  arch/arm/Makefile                                  |   1 +
  arch/arm/boot/dts/Makefile                         |   3 +
  arch/arm/boot/dts/mps2-an385.dts                   |  92 +++
  arch/arm/boot/dts/mps2-an399.dts                   |  92 +++
  arch/arm/boot/dts/mps2.dtsi                        | 241 ++++++++
  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  44 +-
  arch/arm/boot/dts/vexpress-v2m.dtsi                |  44 +-
  arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  47 +-
  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  57 +-
  arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |  37 +-
  arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  41 +-
  arch/arm/configs/mps2_defconfig                    | 109 ++++
  arch/arm/mach-vexpress/Makefile                    |   4 +-
  arch/arm/mach-vexpress/Makefile.boot               |   3 +
  arch/arm/mach-vexpress/v2m-mps2.c                  |  21 +
  drivers/clocksource/Kconfig                        |   6 +
  drivers/clocksource/Makefile                       |   1 +
  drivers/clocksource/mps2-timer.c                   | 275 +++++++++
  drivers/tty/serial/Kconfig                         |  13 +
  drivers/tty/serial/Makefile                        |   1 +
  drivers/tty/serial/mps2-uart.c                     | 625 
+++++++++++++++++++++
  include/uapi/linux/serial_core.h                   |   3 +
  26 files changed, 1710 insertions(+), 110 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
  create mode 100644 
Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
  create mode 100644 arch/arm/boot/dts/mps2-an385.dts
  create mode 100644 arch/arm/boot/dts/mps2-an399.dts
  create mode 100644 arch/arm/boot/dts/mps2.dtsi
  create mode 100644 arch/arm/configs/mps2_defconfig
  create mode 100644 arch/arm/mach-vexpress/Makefile.boot
  create mode 100644 arch/arm/mach-vexpress/v2m-mps2.c
  create mode 100644 drivers/clocksource/mps2-timer.c
  create mode 100644 drivers/tty/serial/mps2-uart.c
