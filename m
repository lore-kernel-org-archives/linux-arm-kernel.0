From: wellsk40@gmail.com (Kevin Wells)
Date: Fri, 12 Mar 2010 12:44:54 -0800
Subject: Git pull request: ARM LPC32XX architecture
Message-ID: <a08234131003121244t6f914926s3ea75e98c017686a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, please pull the reviewed LPC32xx arch files from the
Pengutronix GIT server at:

	git://git.pengutronix.de/git/ukl/linux-2.6.git wells/lpc32xx

This adds support for the ARM: LPC32xx architecture.

Kevin Wells (11):
     ARM: LPC32XX: Initial arch header files
     ARM: LPC32XX: Debug and IRQ macros
     ARM: LPC32XX: Clock driver
     ARM: LPC32XX: GPIO, timer, and IRQ drivers
     ARM: LPC32XX: System suspend support
     ARM: LPC32XX: Serial support code
     ARM: LPC32XX: Misc support functions
     ARM: LPC32XX: Phytec 3250 platform support
     ARM: LPC32XX: Arch config menu supoport and makefiles
     ARM: LPC32XX: Default PHY3250 kernel config (ramdisk)
     ARM: Add support for the LPC32XX arch

arch/arm/Kconfig                                 |   15 +
arch/arm/Makefile                                |    1 +
arch/arm/configs/phy3250_defconfig               | 1099 +++++++++++++++++++++
arch/arm/mach-lpc32xx/Kconfig                    |   33 +
arch/arm/mach-lpc32xx/Makefile                   |    8 +
arch/arm/mach-lpc32xx/Makefile.boot              |    4 +
arch/arm/mach-lpc32xx/clock.c                    | 1137 ++++++++++++++++++++++
arch/arm/mach-lpc32xx/clock.h                    |   38 +
arch/arm/mach-lpc32xx/common.c                   |  271 +++++
arch/arm/mach-lpc32xx/common.h                   |   73 ++
arch/arm/mach-lpc32xx/gpiolib.c                  |  446 +++++++++
arch/arm/mach-lpc32xx/include/mach/clkdev.h      |   25 +
arch/arm/mach-lpc32xx/include/mach/debug-macro.S |   31 +
arch/arm/mach-lpc32xx/include/mach/entry-macro.S |   47 +
arch/arm/mach-lpc32xx/include/mach/gpio.h        |   74 ++
arch/arm/mach-lpc32xx/include/mach/hardware.h    |   34 +
arch/arm/mach-lpc32xx/include/mach/i2c.h         |   63 ++
arch/arm/mach-lpc32xx/include/mach/io.h          |   27 +
arch/arm/mach-lpc32xx/include/mach/irqs.h        |  117 +++
arch/arm/mach-lpc32xx/include/mach/memory.h      |   27 +
arch/arm/mach-lpc32xx/include/mach/platform.h    |  694 ++++++++++++
arch/arm/mach-lpc32xx/include/mach/system.h      | 2 +
arch/arm/mach-lpc32xx/include/mach/timex.h       |   28 +
arch/arm/mach-lpc32xx/include/mach/uncompress.h  |   60 ++
arch/arm/mach-lpc32xx/include/mach/vmalloc.h     |   24 +
arch/arm/mach-lpc32xx/irq.c                      |  432 ++++++++
arch/arm/mach-lpc32xx/phy3250.c                  |  397 ++++++++
arch/arm/mach-lpc32xx/pm.c                       |  145 +++
arch/arm/mach-lpc32xx/serial.c                   |  190 ++++
arch/arm/mach-lpc32xx/suspend.S                  |  151 +++
arch/arm/mach-lpc32xx/timer.c                    |  182 ++++
31 files changed, 5925 insertions(+), 0 deletions(-)
create mode 100644 arch/arm/configs/phy3250_defconfig
create mode 100644 arch/arm/mach-lpc32xx/Kconfig
create mode 100644 arch/arm/mach-lpc32xx/Makefile
create mode 100644 arch/arm/mach-lpc32xx/Makefile.boot
create mode 100644 arch/arm/mach-lpc32xx/clock.c
create mode 100644 arch/arm/mach-lpc32xx/clock.h
create mode 100644 arch/arm/mach-lpc32xx/common.c
create mode 100644 arch/arm/mach-lpc32xx/common.h
create mode 100644 arch/arm/mach-lpc32xx/gpiolib.c
create mode 100644 arch/arm/mach-lpc32xx/include/mach/clkdev.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/debug-macro.S
create mode 100644 arch/arm/mach-lpc32xx/include/mach/entry-macro.S
create mode 100644 arch/arm/mach-lpc32xx/include/mach/gpio.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/hardware.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/i2c.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/io.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/irqs.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/memory.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/platform.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/system.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/timex.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/uncompress.h
create mode 100644 arch/arm/mach-lpc32xx/include/mach/vmalloc.h
create mode 100644 arch/arm/mach-lpc32xx/irq.c
create mode 100644 arch/arm/mach-lpc32xx/phy3250.c
create mode 100644 arch/arm/mach-lpc32xx/pm.c
create mode 100644 arch/arm/mach-lpc32xx/serial.c
create mode 100644 arch/arm/mach-lpc32xx/suspend.S
create mode 100644 arch/arm/mach-lpc32xx/timer.c

thanks,
Kevin Wells
NXP Semiconductors
