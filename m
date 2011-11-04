From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Nov 2011 14:53:50 +0900
Subject: [GIT PULL] Samsung devel-4 for v3.2
Message-ID: <027f01cc9ab6$2086eae0$6194c0a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

As we talked in Prague, I'm sending 'pull request for v3.2' Samsung-devel4
which includes supporting EXYNOS4 DT, SPI clkdev and reorganization
arch/arm/mach-exynos and small things.

Please pull from: 
  git://github.com/kgene/linux-samsung.git next-samsung-devel-4

As a note, the branch includes arm-soc/next/cleanup3 and arm-soc/next/devel2
based on mainline commit 994c0e99 ("Merge branch 'next/soc' of
git://git.linaro.org/people/arnd/arm-soc") because it is needed for this and
they include all of Samsung stuff for v3.2.

And I will be back to kernel.org after this merge window.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 2ef9270f2481543e49bfbdc0d125f0bf3068d246:

  Merge remote branch 'arm-soc/next/devel2' into next-samsung-dt (2011-11-02
19:12:59 +0900)

are available in the git repository at:

  git://github.com/kgene/linux-samsung.git next-samsung-devel-4

Jonghwan Choi (1):
      ARM: SAMSUNG: Fix compile error due to kfree

Joonyoung Shim (1):
      ARM: SAMSUNG: Add clk enable/disable of pwm

Kukjin Kim (1):
      ARM: EXYNOS: Add ARCH_EXYNOS and reorganize arch/arm/mach-exynos

Marc Zyngier (1):
      ARM: EXYNOS4: convert MCT to percpu interrupt API

Mark Brown (3):
      ARM: S3C64XX: Update for conversion to SAMSUNG_GPIO_EXTRA
      ARM: SAMSUNG: Fix GPIO space reservation for S3C64xx platforms
      ARM: S3C64XX: Correct reservation of GPIOs for CPU module on
Cragganmore

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
      ARM: EXYNOS4: Enable Bluetooth on ORIGEN

Thomas Abraham (28):
      ARM: SAMSUNG: Move timer irq numbers to end of linux irq space
      ARM: EXYNOS4: Add ioremap interceptor for statically remapped regions
      ARM: EXYNOS4: Enable conversion of GIC dt irq specifier to linux virq
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
      ARM: EXYNOS4: Modify platform data for pl330 driver
      DMA: PL330: Add device tree support
      ARM: SAMSUNG: Add device tree support for pl330 dma engine wrappers
      ARM: EXYNOS4: Limit usage of pl330 device instance to non-dt build
      ARM: EXYNOS4: Add a alias for pdma clocks
      ARM: S5P64x0: Modify platform data for pl330 driver
      ARM: S5PC100: Modify platform data for pl330 driver
      ARM: S5PV210: Modify platform data for pl330 driver
      input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config option
      input: samsung-keypad: Add device tree support
      rtc: rtc-s3c: Add device tree support
      ARM: EXYNOS4: Add Exynos4 device tree enabled board file
      ARM: dts: Add intial dts file for EXYNOS4210 SoC, SMDKV310 and ORIGEN

 .../devicetree/bindings/arm/insignal-boards.txt    |    8 +
 .../devicetree/bindings/arm/samsung-boards.txt     |    8 +
 .../devicetree/bindings/dma/arm-pl330.txt          |   30 +
 .../devicetree/bindings/gpio/gpio-samsung.txt      |   40 ++
 .../devicetree/bindings/input/samsung-keypad.txt   |   88 +++
 Documentation/devicetree/bindings/rtc/s3c-rtc.txt  |   20 +
 .../devicetree/bindings/serial/samsung_uart.txt    |   14 +
 arch/arm/Kconfig                                   |    8 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |  137 +++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  182 ++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  397 ++++++++++++
 arch/arm/configs/exynos4_defconfig                 |    9 +-
 arch/arm/{mach-exynos4 => mach-exynos}/Kconfig     |   63 ++-
 arch/arm/{mach-exynos4 => mach-exynos}/Makefile    |   15 +-
 .../{mach-exynos4 => mach-exynos}/Makefile.boot    |    0
 .../clock-exynos4210.c                             |    0
 .../clock-exynos4212.c                             |    0
 arch/arm/{mach-exynos4 => mach-exynos}/clock.c     |  229 +++++---
 arch/arm/{mach-exynos4 => mach-exynos}/cpu.c       |  102 +++-
 arch/arm/{mach-exynos4 => mach-exynos}/cpuidle.c   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-ahci.c  |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-audio.c |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-dwmci.c |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-pd.c    |    0
 .../arm/{mach-exynos4 => mach-exynos}/dev-sysmmu.c |    0
 arch/arm/mach-exynos/dma.c                         |  157 +++++
 arch/arm/{mach-exynos4 => mach-exynos}/headsmp.S   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/hotplug.c   |    0
 .../include/mach/debug-macro.S                     |    0
 .../include/mach/dma.h                             |    0
 .../include/mach/dwmci.h                           |    0
 .../include/mach/entry-macro.S                     |    1 -
 .../include/mach/exynos4-clock.h                   |    0
 .../include/mach/gpio.h                            |    0
 .../include/mach/hardware.h                        |    0
 .../include/mach/io.h                              |    5 +
 .../include/mach/irqs.h                            |    8 +-
 .../include/mach/map.h                             |   32 +-
 .../include/mach/memory.h                          |    0
 .../include/mach/pm-core.h                         |    0
 .../include/mach/pmu.h                             |    0
 .../include/mach/regs-audss.h                      |    0
 .../include/mach/regs-clock.h                      |    0
 .../include/mach/regs-gpio.h                       |    0
 .../include/mach/regs-irq.h                        |    0
 .../include/mach/regs-mct.h                        |    0
 .../include/mach/regs-mem.h                        |    0
 .../include/mach/regs-pmu.h                        |    0
 .../include/mach/regs-sysmmu.h                     |    0
 .../include/mach/regs-usb-phy.h                    |    0
 .../include/mach/sysmmu.h                          |    0
 .../include/mach/system.h                          |    0
 .../include/mach/timex.h                           |    0
 .../include/mach/uncompress.h                      |    0
 .../include/mach/vmalloc.h                         |    0
 arch/arm/{mach-exynos4 => mach-exynos}/init.c      |   21 +-
 .../{mach-exynos4 => mach-exynos}/irq-combiner.c   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/irq-eint.c  |    0
 .../mach-armlex4210.c                              |    0
 arch/arm/mach-exynos/mach-exynos4-dt.c             |   85 +++
 arch/arm/{mach-exynos4 => mach-exynos}/mach-nuri.c |    0
 .../{mach-exynos4 => mach-exynos}/mach-origen.c    |   34 +
 .../{mach-exynos4 => mach-exynos}/mach-smdk4x12.c  |    0
 .../{mach-exynos4 => mach-exynos}/mach-smdkv310.c  |    0
 .../mach-universal_c210.c                          |    0
 arch/arm/{mach-exynos4 => mach-exynos}/mct.c       |   40 +-
 arch/arm/{mach-exynos4 => mach-exynos}/platsmp.c   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/pm.c        |    0
 arch/arm/{mach-exynos4 => mach-exynos}/pmu.c       |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-fimc.c |    0
 .../{mach-exynos4 => mach-exynos}/setup-fimd0.c    |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c0.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c1.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c2.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c3.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c4.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c5.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c6.c |    0
 .../arm/{mach-exynos4 => mach-exynos}/setup-i2c7.c |    0
 .../{mach-exynos4 => mach-exynos}/setup-keypad.c   |    0
 .../setup-sdhci-gpio.c                             |    0
 .../{mach-exynos4 => mach-exynos}/setup-usb-phy.c  |    0
 arch/arm/mach-exynos4/dma.c                        |  250 --------
 arch/arm/mach-exynos4/setup-sdhci.c                |   22 -
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
 arch/arm/mach-s3c2440/mach-osiris.c                |   24 +-
 arch/arm/mach-s3c2440/mach-rx1950.c                |   18 +-
 arch/arm/mach-s3c2440/mach-rx3715.c                |   19 +-
 arch/arm/mach-s3c64xx/Kconfig                      |    6 +-
 arch/arm/mach-s3c64xx/Makefile                     |    1 -
 arch/arm/mach-s3c64xx/clock.c                      |  243 +++++---
 arch/arm/mach-s3c64xx/dev-spi.c                    |    7 -
 arch/arm/mach-s3c64xx/include/mach/crag6410.h      |    3 +-
 arch/arm/mach-s3c64xx/include/mach/gpio.h          |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
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
 arch/arm/plat-s5p/Kconfig                          |    2 +-
 arch/arm/plat-s5p/cpu.c                            |    6 +-
 arch/arm/plat-samsung/Kconfig                      |    8 +
 arch/arm/plat-samsung/dev-backlight.c              |    1 +
 arch/arm/plat-samsung/dma-ops.c                    |   15 +-
 arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 +
 arch/arm/plat-samsung/include/plat/dma-pl330.h     |    3 +-
 arch/arm/plat-samsung/include/plat/exynos4.h       |    6 +-
 arch/arm/plat-samsung/include/plat/irqs.h          |    3 +-
 arch/arm/plat-samsung/include/plat/regs-serial.h   |   45 +-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |    2 -
 arch/arm/plat-samsung/include/plat/sdhci.h         |   31 -
 arch/arm/plat-samsung/pwm.c                        |    7 +
 drivers/dma/pl330.c                                |   99 ++--
 drivers/gpio/gpio-samsung.c                        |   72 +++
 drivers/input/keyboard/Kconfig                     |    9 +-
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
 156 files changed, 3305 insertions(+), 2963 deletions(-)
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
 rename arch/arm/{mach-exynos4 => mach-exynos}/Kconfig (83%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/Makefile (82%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/Makefile.boot (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock-exynos4210.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock-exynos4212.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock.c (89%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/cpu.c (81%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/cpuidle.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-ahci.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-audio.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-dwmci.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-pd.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-sysmmu.c (100%)
 create mode 100644 arch/arm/mach-exynos/dma.c
 rename arch/arm/{mach-exynos4 => mach-exynos}/headsmp.S (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/hotplug.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/debug-macro.S
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/dma.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/dwmci.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/entry-macro.S
(98%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/exynos4-clock.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/gpio.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/hardware.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/io.h (81%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/irqs.h (96%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/map.h (93%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/memory.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/pm-core.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/pmu.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-audss.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-clock.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-gpio.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-irq.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-mct.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-mem.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-pmu.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-sysmmu.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/regs-usb-phy.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/sysmmu.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/system.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/timex.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/uncompress.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/vmalloc.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/init.c (56%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/irq-combiner.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/irq-eint.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-armlex4210.c (100%)
 create mode 100644 arch/arm/mach-exynos/mach-exynos4-dt.c
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-nuri.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-origen.c (95%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-smdk4x12.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-smdkv310.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-universal_c210.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mct.c (91%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/platsmp.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/pm.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/pmu.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-fimc.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-fimd0.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c0.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c1.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c2.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c3.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c4.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c5.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c6.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-i2c7.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-keypad.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-sdhci-gpio.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-usb-phy.c (100%)
 delete mode 100644 arch/arm/mach-exynos4/dma.c
 delete mode 100644 arch/arm/mach-exynos4/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c64xx/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c
 delete mode 100644 drivers/tty/serial/s3c2410.c
 delete mode 100644 drivers/tty/serial/s3c2412.c
 delete mode 100644 drivers/tty/serial/s3c2440.c
 delete mode 100644 drivers/tty/serial/s3c6400.c
 delete mode 100644 drivers/tty/serial/s5pv210.c
