From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Dec 2011 09:48:39 +0900
Subject: [GIT PULL] Samsung devel-dt for v3.3
Message-ID: <087d01ccc1d5$c6aa8300$53ff8900$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the samsung-devel-dt for v3.3.
It includes support DT for Samsung EXYNOS4. 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 384703b8e6cd4c8ef08512e596024e028c91c339:

  Linux 3.2-rc6 (2011-12-16 18:36:26 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel-dt1

Mark Brown (1):
      serial: samsung: Fix build for non-Exynos4210 devices

Thomas Abraham (26):
      ARM: SAMSUNG: Move timer irq numbers to end of linux irq space
      ARM: EXYNOS: Enable conversion of GIC dt irq specifier to linux virq
      gpio/samsung: Add device tree support for EXYNOS4
      serial: samsung: Keep a copy of the location of platform data in
driver's private data
      ARM: S3C2440: move handling of fclk/n clock to platform code
      serial: samsung: switch to clkdev based clock lookup
      ARM: SAMSUNG: remove struct 's3c24xx_uart_clksrc' and all uses of it
      serial: samsung: remove all uses of get_clksrc and set_clksrc
      ARM: SAMSUNG: register uart clocks to clock lookup list
      serial: samsung: merge all SoC specific port reset functions
      serial: samsung: merge probe() function from all SoC specific
extensions
      serial: samsung: add device tree support
      DMA: PL330: move filter function into driver
      DMA: PL330: Infer transfer direction from transfer request instead of
platform data
      ARM: EXYNOS: Modify platform data for pl330 driver
      DMA: PL330: Add device tree support
      ARM: SAMSUNG: Add device tree support for pl330 dma engine wrappers
      ARM: EXYNOS: Limit usage of pl330 device instance to non-dt build
      ARM: EXYNOS: Add a alias for pdma clocks
      ARM: S5P64x0: Modify platform data for pl330 driver
      ARM: S5PC100: Modify platform data for pl330 driver
      ARM: S5PV210: Modify platform data for pl330 driver
      input: samsung-keypad: Add device tree support
      rtc: rtc-s3c: Add device tree support
      ARM: EXYNOS: Add Exynos4 device tree enabled board file
      ARM: dts: Add intial dts file for EXYNOS4210 SoC, SMDKV310 and ORIGEN

 .../devicetree/bindings/arm/insignal-boards.txt    |    8 +
 .../devicetree/bindings/arm/samsung-boards.txt     |    8 +
 .../devicetree/bindings/dma/arm-pl330.txt          |   30 +
 .../devicetree/bindings/gpio/gpio-samsung.txt      |   40 ++
 .../devicetree/bindings/input/samsung-keypad.txt   |   88 +++
 Documentation/devicetree/bindings/rtc/s3c-rtc.txt  |   20 +
 .../devicetree/bindings/serial/samsung_uart.txt    |   14 +
 arch/arm/boot/dts/exynos4210-origen.dts            |  137 +++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  182 ++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  397 ++++++++++++
 arch/arm/mach-exynos/Kconfig                       |   24 +
 arch/arm/mach-exynos/Makefile                      |    5 +-
 arch/arm/mach-exynos/clock.c                       |  141 +++--
 arch/arm/mach-exynos/cpu.c                         |   17 +-
 arch/arm/mach-exynos/dma.c                         |  229 ++-----
 arch/arm/mach-exynos/include/mach/entry-macro.S    |    1 -
 arch/arm/mach-exynos/include/mach/irqs.h           |    8 +-
 arch/arm/mach-exynos/init.c                        |   21 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c             |   85 +++
 arch/arm/mach-s3c2410/mach-bast.c                  |   22 -
 arch/arm/mach-s3c2410/mach-vr1000.c                |   24 -
 arch/arm/mach-s3c2410/s3c2410.c                    |    6 +
 arch/arm/mach-s3c2412/clock.c                      |    7 +
 arch/arm/mach-s3c2440/clock.c                      |   44 ++
 arch/arm/mach-s3c2440/mach-anubis.c                |   22 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c             |   22 +-
 arch/arm/mach-s3c2440/mach-osiris.c                |   24 +-
 arch/arm/mach-s3c2440/mach-rx1950.c                |   18 +-
 arch/arm/mach-s3c2440/mach-rx3715.c                |   19 +-
 arch/arm/mach-s3c64xx/clock.c                      |   37 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |   32 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |   32 +-
 arch/arm/mach-s5p64x0/dma.c                        |  227 ++-----
 arch/arm/mach-s5p64x0/include/mach/irqs.h          |    2 +
 arch/arm/mach-s5p64x0/init.c                       |   31 -
 arch/arm/mach-s5pc100/clock.c                      |   33 +-
 arch/arm/mach-s5pc100/dma.c                        |  247 +++------
 arch/arm/mach-s5pc100/include/mach/irqs.h          |    2 +
 arch/arm/mach-s5pv210/clock.c                      |  107 ++--
 arch/arm/mach-s5pv210/dma.c                        |  241 +++------
 arch/arm/mach-s5pv210/include/mach/irqs.h          |    2 +
 arch/arm/mach-s5pv210/init.c                       |   19 -
 arch/arm/plat-s3c24xx/s3c2443-clock.c              |   23 +-
 arch/arm/plat-samsung/dma-ops.c                    |   15 +-
 arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 +
 arch/arm/plat-samsung/include/plat/dma-pl330.h     |    3 +-
 arch/arm/plat-samsung/include/plat/irqs.h          |    3 +-
 arch/arm/plat-samsung/include/plat/regs-serial.h   |   45 +-
 drivers/dma/pl330.c                                |   99 ++--
 drivers/gpio/gpio-samsung.c                        |   72 +++
 drivers/input/keyboard/samsung-keypad.c            |  174 +++++-
 drivers/rtc/rtc-s3c.c                              |   21 +-
 drivers/tty/serial/Kconfig                         |   45 +--
 drivers/tty/serial/Makefile                        |    5 -
 drivers/tty/serial/s3c2410.c                       |  115 ----
 drivers/tty/serial/s3c2412.c                       |  149 -----
 drivers/tty/serial/s3c2440.c                       |  178 ------
 drivers/tty/serial/s3c6400.c                       |  149 -----
 drivers/tty/serial/s5pv210.c                       |  158 -----
 drivers/tty/serial/samsung.c                       |  639
++++++++++++--------
 drivers/tty/serial/samsung.h                       |   32 +-
 include/linux/amba/pl330.h                         |   15 +-
 62 files changed, 2423 insertions(+), 2193 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/arm/insignal-boards.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung-boards.txt
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-samsung.txt
 create mode 100644
Documentation/devicetree/bindings/input/samsung-keypad.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.txt
 create mode 100644
Documentation/devicetree/bindings/serial/samsung_uart.txt
 create mode 100644 arch/arm/boot/dts/exynos4210-origen.dts
 create mode 100644 arch/arm/boot/dts/exynos4210-smdkv310.dts
 create mode 100644 arch/arm/boot/dts/exynos4210.dtsi
 create mode 100644 arch/arm/mach-exynos/mach-exynos4-dt.c
 delete mode 100644 drivers/tty/serial/s3c2410.c
 delete mode 100644 drivers/tty/serial/s3c2412.c
 delete mode 100644 drivers/tty/serial/s3c2440.c
 delete mode 100644 drivers/tty/serial/s3c6400.c
 delete mode 100644 drivers/tty/serial/s5pv210.c
