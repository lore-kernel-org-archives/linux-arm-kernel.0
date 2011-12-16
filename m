From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Dec 2011 16:44:02 +0900
Subject: [GIT PULL] Samsung devel-1 for v3.3
Message-ID: <014a01ccbbc6$7b036300$710a2900$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull next-samsung-devel for v3.3.
It includes DT support for EXYNOS, update Cragganmore board and SPI clkdev
support. As a note, out of arch/arm/samsung stuff got the ack from regarding
maintainers and actually, it has been included in linux-next for long time
so I think, it has no problem for v3.3.

One more, I need to follow up Russell and some arm consolidation work and
one plat-samsung directory and apply some patches in my mail-box ;) It will
be sent to you soon.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel

Boojin Kim (1):
      ARM: EXYNOS: Enable MDMA driver

Denis Kuzmenko (1):
      ARM: S3C2440: Add new LCD (W35i) support for Mini2440 board

Kukjin Kim (2):
      Merge branch 'next/topic-devel-s3c' into next-samsung-devel
      Merge branch 'next/topic-devel-exynos' into next-samsung-devel

Mark Brown (14):
      serial: samsung: Fix build for non-Exynos4210 devices
      ARM: S3C64XX: Update for conversion to SAMSUNG_GPIO_EXTRA
      ARM: SAMSUNG: Fix GPIO space reservation for S3C64xx platforms
      ARM: S3C64XX: Correct reservation of GPIOs for CPU module on
Cragganmore
      ARM: S3C64XX: Raise the frequency of the second I2C bus on Cragganmore
      ARM: S3C64XX: Use software initiated powerdown for Cragganmore
      ARM: S3C64XX: Configure WM1250 EV1 GPIOs on Cragganmore
      ARM: S3C64XX: Improve logging of unknown Cragganmore module types
      ARM: S3C64XX: Run Tobermory interrupts in the default mode
      ARM: S3C64XX: Hook up platform data for Kilchomin module on
Cragganmore
      ARM: S3C64XX: Hook up Littlemill audio card on Cragganmore
      ARM: S3C64XX: Power gate unused domains
      ARM: S3C64XX: Hook up VDDINT on Cragganmore
      ARM: S3C64XX: Gate some more clocks by default

Padmavathi Venna (6):
      spi/s3c64xx: Use bus clocks created using clkdev
      ARM: S3C64XX: Add SPI clkdev support
      ARM: S5PC100: Add SPI clkdev support
      ARM: S5P64X0: Add SPI clkdev support
      ARM: S5PV210: Add SPI clkdev support
      ARM: SAMSUNG: Remove SPI bus clocks from platform data

Rajeshwari Shinde (3):
      ARM: SAMSUNG: Remove SDHCI bus clocks from platform data
      ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using generic names
      mmc: sdhci-s3c: Use generic clock names for sdhci bus clock options

Sangwook Lee (1):
      ARM: EXYNOS: Enable Bluetooth on ORIGEN

Thomas Abraham (27):
      ARM: SAMSUNG: Move timer irq numbers to end of linux irq space
      ARM: EXYNOS: Add ioremap interceptor for statically remapped regions
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
 arch/arm/mach-exynos/Makefile                      |    6 +-
 arch/arm/mach-exynos/clock.c                       |  237 +++++---
 arch/arm/mach-exynos/cpu.c                         |   39 ++-
 arch/arm/mach-exynos/dma.c                         |  264 ++++-----
 arch/arm/mach-exynos/include/mach/entry-macro.S    |    1 -
 arch/arm/mach-exynos/include/mach/io.h             |    5 +
 arch/arm/mach-exynos/include/mach/irqs.h           |   10 +-
 arch/arm/mach-exynos/include/mach/map.h            |    3 +-
 arch/arm/mach-exynos/init.c                        |   21 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c             |   85 +++
 arch/arm/mach-exynos/mach-origen.c                 |   34 +
 arch/arm/mach-exynos/setup-sdhci.c                 |   22 -
 arch/arm/mach-s3c2410/mach-bast.c                  |   22 -
 arch/arm/mach-s3c2410/mach-vr1000.c                |   24 -
 arch/arm/mach-s3c2410/s3c2410.c                    |    6 +
 arch/arm/mach-s3c2412/clock.c                      |    7 +
 arch/arm/mach-s3c2416/Makefile                     |    1 -
 arch/arm/mach-s3c2416/clock.c                      |   68 ++-
 arch/arm/mach-s3c2416/setup-sdhci.c                |   24 -
 arch/arm/mach-s3c2440/clock.c                      |   44 ++
 arch/arm/mach-s3c2440/mach-anubis.c                |   22 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c             |   22 +-
 arch/arm/mach-s3c2440/mach-mini2440.c              |   18 +
 arch/arm/mach-s3c2440/mach-osiris.c                |   24 +-
 arch/arm/mach-s3c2440/mach-rx1950.c                |   18 +-
 arch/arm/mach-s3c2440/mach-rx3715.c                |   19 +-
 arch/arm/mach-s3c64xx/Kconfig                      |    6 +-
 arch/arm/mach-s3c64xx/Makefile                     |    1 -
 arch/arm/mach-s3c64xx/clock.c                      |  263 +++++---
 arch/arm/mach-s3c64xx/dev-spi.c                    |    7 -
 arch/arm/mach-s3c64xx/include/mach/crag6410.h      |    6 +-
 arch/arm/mach-s3c64xx/include/mach/gpio.h          |    2 +-
 arch/arm/mach-s3c64xx/include/mach/irqs.h          |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |   56 ++-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |   39 ++-
 arch/arm/mach-s3c64xx/pm.c                         |   15 +
 arch/arm/mach-s3c64xx/setup-sdhci.c                |   24 -
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |   93 ++--
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |   81 ++-
 arch/arm/mach-s5p64x0/dev-spi.c                    |    6 -
 arch/arm/mach-s5p64x0/dma.c                        |  227 ++-----
 arch/arm/mach-s5p64x0/include/mach/irqs.h          |    2 +
 arch/arm/mach-s5p64x0/init.c                       |   31 -
 arch/arm/mach-s5pc100/Makefile                     |    1 -
 arch/arm/mach-s5pc100/clock.c                      |  287 ++++++----
 arch/arm/mach-s5pc100/dev-spi.c                    |    7 -
 arch/arm/mach-s5pc100/dma.c                        |  247 +++------
 arch/arm/mach-s5pc100/include/mach/irqs.h          |    2 +
 arch/arm/mach-s5pc100/setup-sdhci.c                |   23 -
 arch/arm/mach-s5pv210/Makefile                     |    1 -
 arch/arm/mach-s5pv210/clock.c                      |  324 ++++++----
 arch/arm/mach-s5pv210/dev-spi.c                    |    6 -
 arch/arm/mach-s5pv210/dma.c                        |  241 +++------
 arch/arm/mach-s5pv210/include/mach/irqs.h          |    2 +
 arch/arm/mach-s5pv210/init.c                       |   19 -
 arch/arm/mach-s5pv210/setup-sdhci.c                |   22 -
 arch/arm/plat-s3c24xx/s3c2443-clock.c              |   39 +-
 arch/arm/plat-samsung/Kconfig                      |    8 +
 arch/arm/plat-samsung/dma-ops.c                    |   15 +-
 arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 +
 arch/arm/plat-samsung/include/plat/dma-pl330.h     |   11 +-
 arch/arm/plat-samsung/include/plat/irqs.h          |    3 +-
 arch/arm/plat-samsung/include/plat/regs-serial.h   |   45 +-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |    2 -
 arch/arm/plat-samsung/include/plat/sdhci.h         |   31 -
 drivers/dma/pl330.c                                |   99 ++--
 drivers/gpio/gpio-samsung.c                        |   72 +++
 drivers/input/keyboard/samsung-keypad.c            |  174 +++++-
 drivers/mmc/host/sdhci-s3c.c                       |    7 +-
 drivers/rtc/rtc-s3c.c                              |   21 +-
 drivers/spi/spi-s3c64xx.c                          |   14 +-
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
 92 files changed, 3264 insertions(+), 2800 deletions(-)
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
 delete mode 100644 arch/arm/mach-exynos/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c64xx/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c
 delete mode 100644 drivers/tty/serial/s3c2410.c
 delete mode 100644 drivers/tty/serial/s3c2412.c
 delete mode 100644 drivers/tty/serial/s3c2440.c
 delete mode 100644 drivers/tty/serial/s3c6400.c
 delete mode 100644 drivers/tty/serial/s5pv210.c
