From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 15 Jul 2012 16:49:06 +0200
Subject: [PATCH 0/8] ARM: support for Moschip MCS814x SoCs
Message-ID: <1342363754-30808-1-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patchset adds basic support for Mocship MCS814x, and in particular
MCS8140, and allows one booting to user space. Two off-the-shelf boards
are support: Tigal/Robotech RBT-832 and Devolo dLAN USB Extender.

Support for other on-board peripherals will obviously be contributed later
once the basic SoC support has been accepted.

Florian Fainelli (8):
  ARM: support for Moschip MCS814x SoCs
  ARM: MCS814x: add Device Tree based MCS8140 board support
  ARM: MCS814x: add Device Tree bindings documentation
  ARM: MCS814X: add DTS file for Tigal/Robotech RBT-832
  ARM: MCS814x: add DTS file for Devolo dLAN USB Extender
  ARM: MCS814x: provide a sample defconfig file
  ARM: MSC814X: add Kconfig and Makefile to arch/arm
  ARM: MSC814x: add MAINTAINERS entry

 .../bindings/arm/mcs814x/mcs814x-intc.txt          |   18 +
 .../bindings/arm/mcs814x/mcs814x-pci.txt           |   16 +
 .../bindings/arm/mcs814x/mcs814x-timer.txt         |   16 +
 .../devicetree/bindings/arm/mcs814x/mcs814x.txt    |   13 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |   28 ++
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/dlan-usb-extender.dts            |   68 +++
 arch/arm/boot/dts/mcs8140.dtsi                     |  207 +++++++++
 arch/arm/boot/dts/rbt-832.dts                      |   83 ++++
 arch/arm/configs/mcs814x_defconfig                 |  174 ++++++++
 arch/arm/mach-mcs814x/Kconfig                      |   29 ++
 arch/arm/mach-mcs814x/Makefile                     |    6 +
 arch/arm/mach-mcs814x/Makefile.boot                |    6 +
 arch/arm/mach-mcs814x/board-mcs8140-dt.c           |   46 ++
 arch/arm/mach-mcs814x/clock.c                      |  271 ++++++++++++
 arch/arm/mach-mcs814x/common.c                     |   97 +++++
 arch/arm/mach-mcs814x/common.h                     |   15 +
 arch/arm/mach-mcs814x/include/mach/cpu.h           |   16 +
 arch/arm/mach-mcs814x/include/mach/debug-macro.S   |   11 +
 arch/arm/mach-mcs814x/include/mach/entry-macro.S   |   29 ++
 arch/arm/mach-mcs814x/include/mach/gpio.h          |    1 +
 arch/arm/mach-mcs814x/include/mach/hardware.h      |   16 +
 arch/arm/mach-mcs814x/include/mach/irqs.h          |   22 +
 arch/arm/mach-mcs814x/include/mach/mcs814x.h       |   53 +++
 arch/arm/mach-mcs814x/include/mach/memory.h        |   16 +
 arch/arm/mach-mcs814x/include/mach/timex.h         |   18 +
 arch/arm/mach-mcs814x/include/mach/uncompress.h    |   41 ++
 arch/arm/mach-mcs814x/irq.c                        |   69 +++
 arch/arm/mach-mcs814x/pci.c                        |  446 ++++++++++++++++++++
 arch/arm/mach-mcs814x/timer.c                      |  133 ++++++
 32 files changed, 1972 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mcs814x/mcs814x-intc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mcs814x/mcs814x-pci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mcs814x/mcs814x-timer.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mcs814x/mcs814x.txt
 create mode 100644 arch/arm/boot/dts/dlan-usb-extender.dts
 create mode 100644 arch/arm/boot/dts/mcs8140.dtsi
 create mode 100644 arch/arm/boot/dts/rbt-832.dts
 create mode 100644 arch/arm/configs/mcs814x_defconfig
 create mode 100644 arch/arm/mach-mcs814x/Kconfig
 create mode 100644 arch/arm/mach-mcs814x/Makefile
 create mode 100644 arch/arm/mach-mcs814x/Makefile.boot
 create mode 100644 arch/arm/mach-mcs814x/board-mcs8140-dt.c
 create mode 100644 arch/arm/mach-mcs814x/clock.c
 create mode 100644 arch/arm/mach-mcs814x/common.c
 create mode 100644 arch/arm/mach-mcs814x/common.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/cpu.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-mcs814x/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-mcs814x/include/mach/gpio.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/hardware.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/irqs.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/mcs814x.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/memory.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/timex.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-mcs814x/irq.c
 create mode 100644 arch/arm/mach-mcs814x/pci.c
 create mode 100644 arch/arm/mach-mcs814x/timer.c

-- 
1.7.10.4
