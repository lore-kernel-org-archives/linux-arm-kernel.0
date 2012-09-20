From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Sep 2012 19:31:58 -0600
Subject: [GIT PULL] ARM: add basic BCM2835 SoC and Raspberry Pi board support
Message-ID: <1348104718-21751-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM2835 is an ARM SoC from Broadcom. This patch adds very basic
support for this SoC; enough to boot the system into an initrd with
UART console, interrupt controller, timers, and a stub clock driver.

Also provided is a similarly basic device tree for the Raspberry Pi
Model B board.

This series was written by Simon Arlott, Chris Boot, and Dom Cobley
downstream, with reference to a Broadcom tree, and modified for upstream
and submitted by Stephen Warren.

----------------------------------------------------------------

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git rpi-for-3.7

for you to fetch changes up to f680f25c635a1a4327bef34fcbe1e9e3777b546c:

  MAINTAINERS: add an entry for the BCM2835 ARM sub-architecture

----------------------------------------------------------------

Simon Arlott (5):
      ARM: add infra-structure for BCM2835 and Raspberry Pi
      ARM: bcm2835: add interrupt controller driver
      ARM: bcm2835: add system timer
      ARM: bcm2835: add stub clock driver
      ARM: bcm2835: instantiate console UART

Stephen Warren (1):
      MAINTAINERS: add an entry for the BCM2835 ARM sub-architecture

 Documentation/devicetree/bindings/arm/bcm2835.txt  |    8 +
 .../brcm,bcm2835-armctrl-ic.txt                    |  110 +++++++
 .../bindings/timer/brcm,bcm2835-system-timer.txt   |   22 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |   10 +
 arch/arm/Kconfig                                   |   17 ++
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   12 +
 arch/arm/boot/dts/bcm2835.dtsi                     |   39 +++
 arch/arm/configs/bcm2835_defconfig                 |   95 ++++++
 arch/arm/mach-bcm2835/Makefile                     |    1 +
 arch/arm/mach-bcm2835/Makefile.boot                |    5 +
 arch/arm/mach-bcm2835/bcm2835.c                    |   64 +++++
 arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h   |   29 ++
 arch/arm/mach-bcm2835/include/mach/debug-macro.S   |   21 ++
 arch/arm/mach-bcm2835/include/mach/timex.h         |   26 ++
 arch/arm/mach-bcm2835/include/mach/uncompress.h    |   45 +++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-bcm2835.c                          |   59 ++++
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/bcm2835_timer.c                |  161 +++++++++++
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-bcm2835.c                      |  223 +++++++++++++++
 include/linux/bcm2835_timer.h                      |   22 ++
 include/linux/clk/bcm2835.h                        |   24 ++
 include/linux/irqchip/bcm2835.h                    |   29 ++
 28 files changed, 1031 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm2835.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2835.dtsi
 create mode 100644 arch/arm/configs/bcm2835_defconfig
 create mode 100644 arch/arm/mach-bcm2835/Makefile
 create mode 100644 arch/arm/mach-bcm2835/Makefile.boot
 create mode 100644 arch/arm/mach-bcm2835/bcm2835.c
 create mode 100644 arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h
 create mode 100644 arch/arm/mach-bcm2835/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-bcm2835/include/mach/timex.h
 create mode 100644 arch/arm/mach-bcm2835/include/mach/uncompress.h
 create mode 100644 drivers/clk/clk-bcm2835.c
 create mode 100644 drivers/clocksource/bcm2835_timer.c
 create mode 100644 drivers/irqchip/Kconfig
 create mode 100644 drivers/irqchip/Makefile
 create mode 100644 drivers/irqchip/irq-bcm2835.c
 create mode 100644 include/linux/bcm2835_timer.h
 create mode 100644 include/linux/clk/bcm2835.h
 create mode 100644 include/linux/irqchip/bcm2835.h
