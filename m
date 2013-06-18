From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 04:59:41 +0900
Subject: [GIT PULL 00/10] Samsung 2nd pull-request for v3.11
Message-ID: <51C0BC2D.80705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This is 2nd pull-request for Samsung stuff for v3.11.

This is including following branches.
v3.11-next/cleanup-samsung
v3.11-next/exynos-arch-2
v3.11-next/exynos-dt-2
v3.11-next/s3c24xx-dt-2
v3.11-next/dt-n-clk-audio
v3.11-next/remove-nondt-exynos-3
v3.11-next/s3c24xx-pinctrl-2
v3.11-next/soc-exynos5420
v3.11-next/samsung-defconfig
v3.11-next/non-critical-fixes

Just note, for remove-nondt-exynos-3 branch, small merge conflict will 
be happened. I added my resolution in the pull-request.

If any problems, please kindly let me know.

Thanks,
- Kukjin


Amit Daniel Kachhap (1):
       ARM: dts: Add more opp levels in exynos5440

Arnd Bergmann (4):
       ARM: EXYNOS: Remove custom init_irq callbacks
       ARM: EXYNOS: Use exynos_init_io() as map_io callback
       ARM: EXYNOS: Remove legacy L2X0 initialization
       ARM: EXYNOS: Remove remaining dead code after non-DT support removal

Chander Kashyap (10):
       ARM: dts: fork out common EXYNOS5 nodes
       ARM: dts: list the CPU nodes for EXYNOS5250
       ARM: EXYNOS: Add support for EXYNOS5420 SoC
       serial: samsung: select EXYNOS specific driver data if 
ARCH_EXYNOS is defined
       ARM: EXYNOS: use four additional chipid bits to identify EXYNOS 
family
       clk: exynos5420: register clocks using common clock framework
       ARM: dts: Add initial device tree support for EXYNOS5420
       clocksource: exynos_mct: use (request/free)_irq calls for local 
timer registration
       ARM: EXYNOS: add secondary CPU boot base location for EXYNOS5420
       ARM: EXYNOS: extend soft-reset support for EXYNOS5420

Doug Anderson (3):
       ARM: dts: Enable RTC node for exynos5250-snow
       MAINTAINERS: Add exynos filename match to ARM/S5P EXYNOS ARM 
ARCHITECTURES
       ARM: EXYNOS: Select PINCTRL_EXYNOS for exynos4/5 at chip level

Giridhar Maruthy (1):
       ARM: dts: Removing pdma for exynos5440

Girish K S (1):
       ARM: dts: enable spi for EXYNOS5440 SOC

Heiko Stuebner (2):
       ARM: S3C24XX: update uart addresses in s3c2416-dt auxdata
       pinctrl: s3c24xx: use correct header for chained_irq functions

Kukjin Kim (1):
       ARM: EXYNOS: no more support non-DT for EXYNOS SoCs

Leela Krishna Amudala (2):
       Documentation: Add examples to samsung-pinctrl device tree 
bindings documentation
       ARM: EXYNOS: call scu_enable() only in case of cortex-A9 processor

Padmavathi Venna (7):
       ARM: dts: Add wm8994 regulator support on smdk5250
       ARM: dts: use #include for all device trees for Samsung
       clk: samsung: register audio subsystem clocks using common clock 
framework
       ARM: dts: add Exynos audio subsystem clock controller node
       ARM: dts: add clock provider information for i2s controllers in 
Exynos5250
       ARM: dts: Update Samsung I2S documentation
       clk: exynos5250: Add enum entries for divider clock of i2s1 and i2s2

Sachin Kamat (3):
       ARM: dts: Add PWM related pinctrl entries for exynos4210
       ARM: dts: Add LCD related pinctrl entries for exynos4210
       ARM: dts: Add FIMD node to Origen4210 board

Subash Patel (1):
       ARM: dts: update bootargs to support 8GiB for SSDK5440 and SD5v1

Tomasz Figa (37):
       ARM: EXYNOS: Remove unused board files
       ARM: EXYNOS: Make ARCH_EXYNOS select USE_OF
       ARM: SAMSUNG: Introduce SAMSUNG_ATAGS Kconfig entry
       ARM: EXYNOS: Remove legacy PMU initialization code
       ARM: EXYNOS: Remove legacy EINT initialization code
       ARM: EXYNOS: Remove legacy UART initialization code
       ARM: EXYNOS: Remove legacy dev- and setup- files
       ARM: EXYNOS: Remove legacy interrupt initialization code
       ARM: EXYNOS: Remove legacy timer initialization code
       ARM: EXYNOS: Remove platform device initialization
       ARM: EXYNOS: Remove legacy mapping of chip ID block
       ARM: EXYNOS: Remove check for device tree presence
       ARM: EXYNOS: Remove legacy power domain registration code
       ARM: SAMSUNG: Introduce GPIO_SAMSUNG Kconfig entry
       ARM: EXYNOS: Provide compatibility stubs for PM code in pm-core.h 
header
       ARM: SAMSUNG: Compile legacy IRQ and GPIO PM code only with ATAGS 
support
       platform: Check for ARCH_EXYNOS separately
       USB: Check for ARCH_EXYNOS separately
       ARM: EXYNOS: Decouple ARCH_EXYNOS from PLAT_S5P
       ARM: SAMSUNG: Include most of mach/ headers conditionally
       ARM: EXYNOS: Do not select legacy Kconfig symbols any more
       ARM: EXYNOS: Remove setup-i2c0.c
       ARM: EXYNOS: Remove mach/gpio.h
       ARM: EXYNOS: Remove mach/regs-gpio.h header
       ARM: SAMSUNG: Make legacy MFC support code depend on SAMSUNG_ATAGS
       ARM: EXYNOS: Select SPARSE_IRQ for Exynos
       ARM: EXYNOS: Remove mach/irqs.h header
       ARM: EXYNOS: Remove unused base addresses from mach/map.h header
       thermal: exynos: Support both EXYNOS4X12 SoCs
       ARM: EXYNOS: Remove mach/regs-usb-phy.h header
       ARM: S5P64X0: Use common uncompress.h part for plat-samsung
       watchdog: s3c2410_wdt: Use local register definitions
       ARM: SAMSUNG: Use local definitions of watchdog registers
       ARM: SAMSUNG: Add watchdog reset driver
       ARM: SAMSUNG: Let platforms use the new watchdog reset driver
       ARM: SAMSUNG: Remove legacy watchdog reset code
       ARM: SAMSUNG: Remove unused plat/regs-watchdog.h header

Tushar Behera (4):
       ARM: dts: Enable RTC node for Arndale
       ARM: exynos_defconfig: Enable GPIO buttons and RTC drivers
       ARM: dts: Set BUCK7 as always on for Origen board
       ARM: SAMSUNG: Consolidate uncompress subroutine

Vivek Gautam (1):
       ARM: EXYNOS: Enable XHCI support on exynos5


  .../devicetree/bindings/clock/clk-exynos-audss.txt |   64 +
  .../devicetree/bindings/clock/exynos5420-clock.txt |  201 +++
  .../bindings/pinctrl/samsung-pinctrl.txt           |   44 +-
  .../devicetree/bindings/sound/samsung-i2s.txt      |   46 +-
  MAINTAINERS                                        |    1 +
  arch/arm/Kconfig                                   |   18 +-
  arch/arm/Makefile                                  |    1 +
  arch/arm/boot/dts/Makefile                         |    1 +
  arch/arm/boot/dts/exynos4.dtsi                     |    2 +-
  arch/arm/boot/dts/exynos4210-origen.dts            |   24 +-
  arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |   89 ++
  arch/arm/boot/dts/exynos4210-smdkv310.dts          |    2 +-
  arch/arm/boot/dts/exynos4210-trats.dts             |    2 +-
  arch/arm/boot/dts/exynos4210-universal_c210.dts    |    2 +-
  arch/arm/boot/dts/exynos4210.dtsi                  |    4 +-
  arch/arm/boot/dts/exynos4212.dtsi                  |    2 +-
  arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 +-
  arch/arm/boot/dts/exynos4412-origen.dts            |    2 +-
  arch/arm/boot/dts/exynos4412-smdk4412.dts          |    2 +-
  arch/arm/boot/dts/exynos4412.dtsi                  |    2 +-
  arch/arm/boot/dts/exynos4x12.dtsi                  |    4 +-
  arch/arm/boot/dts/exynos5.dtsi                     |  111 ++
  arch/arm/boot/dts/exynos5250-arndale.dts           |    5 +-
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   39 +-
  arch/arm/boot/dts/exynos5250-snow.dts              |    8 +-
  arch/arm/boot/dts/exynos5250.dtsi                  |   92 +-
  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   33 +
  arch/arm/boot/dts/exynos5420.dtsi                  |  103 ++
  arch/arm/boot/dts/exynos5440-sd5v1.dts             |    4 +-
  arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   43 +-
  arch/arm/boot/dts/exynos5440.dtsi                  |   43 +-
  arch/arm/boot/dts/s3c2416-smdk2416.dts             |    2 +-
  arch/arm/boot/dts/s3c2416.dtsi                     |    4 +-
  arch/arm/boot/dts/s3c24xx.dtsi                     |    2 +-
  arch/arm/configs/exynos_defconfig                  |    3 +
  arch/arm/mach-exynos/Kconfig                       |  360 +-----
  arch/arm/mach-exynos/Makefile                      |   33 -
  arch/arm/mach-exynos/common.c                      |  565 +--------
  arch/arm/mach-exynos/common.h                      |    4 +-
  arch/arm/mach-exynos/dev-ahci.c                    |  255 ----
  arch/arm/mach-exynos/dev-audio.c                   |  254 ----
  arch/arm/mach-exynos/dev-ohci.c                    |   52 -
  arch/arm/mach-exynos/dev-uart.c                    |   55 -
  arch/arm/mach-exynos/dma.c                         |  322 -----
  arch/arm/mach-exynos/firmware.c                    |   22 +-
  arch/arm/mach-exynos/include/mach/gpio.h           |  289 ----
  arch/arm/mach-exynos/include/mach/irqs.h           |  476 -------
  arch/arm/mach-exynos/include/mach/map.h            |  214 ---
  arch/arm/mach-exynos/include/mach/pm-core.h        |   12 +-
  arch/arm/mach-exynos/include/mach/regs-gpio.h      |   40 -
  arch/arm/mach-exynos/include/mach/regs-usb-phy.h   |   74 --
  arch/arm/mach-exynos/include/mach/uncompress.h     |   10 +-
  arch/arm/mach-exynos/mach-armlex4210.c             |  207 ---
  arch/arm/mach-exynos/mach-exynos4-dt.c             |    8 +-
  arch/arm/mach-exynos/mach-exynos5-dt.c             |    9 +-
  arch/arm/mach-exynos/mach-nuri.c                   | 1388 
--------------------
  arch/arm/mach-exynos/mach-origen.c                 |  823 ------------
  arch/arm/mach-exynos/mach-smdk4x12.c               |  396 ------
  arch/arm/mach-exynos/mach-smdkv310.c               |  444 -------
  arch/arm/mach-exynos/mach-universal_c210.c         | 1159 ----------------
  arch/arm/mach-exynos/platsmp.c                     |   14 +-
  arch/arm/mach-exynos/pm.c                          |    1 -
  arch/arm/mach-exynos/pm_domains.c                  |  101 +--
  arch/arm/mach-exynos/setup-fimc.c                  |   44 -
  arch/arm/mach-exynos/setup-fimd0.c                 |   43 -
  arch/arm/mach-exynos/setup-i2c0.c                  |   29 -
  arch/arm/mach-exynos/setup-i2c1.c                  |   23 -
  arch/arm/mach-exynos/setup-i2c2.c                  |   23 -
  arch/arm/mach-exynos/setup-i2c3.c                  |   23 -
  arch/arm/mach-exynos/setup-i2c4.c                  |   23 -
  arch/arm/mach-exynos/setup-i2c5.c                  |   23 -
  arch/arm/mach-exynos/setup-i2c6.c                  |   23 -
  arch/arm/mach-exynos/setup-i2c7.c                  |   23 -
  arch/arm/mach-exynos/setup-keypad.c                |   36 -
  arch/arm/mach-exynos/setup-sdhci-gpio.c            |  152 ---
  arch/arm/mach-exynos/setup-spi.c                   |   45 -
  arch/arm/mach-exynos/setup-usb-phy.c               |  223 ----
  arch/arm/mach-s3c24xx/Kconfig                      |    2 +
  arch/arm/mach-s3c24xx/include/mach/uncompress.h    |    3 +
  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |    8 +-
  arch/arm/mach-s3c24xx/s3c2410.c                    |    3 +-
  arch/arm/mach-s3c24xx/s3c244x.c                    |    3 +-
  arch/arm/mach-s3c64xx/common.c                     |    8 +-
  arch/arm/mach-s3c64xx/include/mach/uncompress.h    |    3 +
  arch/arm/mach-s5p64x0/common.c                     |    4 +-
  arch/arm/mach-s5p64x0/include/mach/uncompress.h    |  162 +---
  arch/arm/mach-s5pc100/common.c                     |    3 +-
  arch/arm/mach-s5pc100/include/mach/uncompress.h    |    2 +
  arch/arm/mach-s5pv210/include/mach/uncompress.h    |    2 +
  arch/arm/plat-samsung/Kconfig                      |   53 +-
  arch/arm/plat-samsung/Makefile                     |   12 +-
  arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
  arch/arm/plat-samsung/include/plat/pm.h            |    5 +
  arch/arm/plat-samsung/include/plat/regs-watchdog.h |   41 -
  arch/arm/plat-samsung/include/plat/uncompress.h    |   21 +-
  .../arm/plat-samsung/include/plat/watchdog-reset.h |   38 +-
  arch/arm/plat-samsung/init.c                       |    8 +-
  arch/arm/plat-samsung/pm-gpio.c                    |    5 +-
  arch/arm/plat-samsung/pm.c                         |    8 +-
  arch/arm/plat-samsung/s5p-dev-mfc.c                |   11 +-
  arch/arm/plat-samsung/watchdog-reset.c             |   97 ++
  drivers/clk/samsung/Makefile                       |    2 +
  drivers/clk/samsung/clk-exynos-audss.c             |  133 ++
  drivers/clk/samsung/clk-exynos5250.c               |    5 +-
  drivers/clk/samsung/clk-exynos5420.c               |  762 +++++++++++
  drivers/clocksource/exynos_mct.c                   |   35 +-
  drivers/gpio/Kconfig                               |    7 +
  drivers/gpio/Makefile                              |    2 +-
  drivers/media/platform/Kconfig                     |    6 +-
  drivers/media/platform/exynos4-is/Kconfig          |    3 +-
  drivers/media/platform/s5p-tv/Kconfig              |    2 +-
  drivers/pinctrl/Kconfig                            |    5 +-
  drivers/pinctrl/pinctrl-s3c24xx.c                  |    3 +-
  drivers/thermal/exynos_thermal.c                   |    3 +-
  drivers/tty/serial/samsung.c                       |    4 +-
  drivers/usb/Kconfig                                |    1 +
  drivers/usb/host/Kconfig                           |    2 +-
  drivers/watchdog/s3c2410_wdt.c                     |   17 +-
  include/dt-bindings/clk/exynos-audss-clk.h         |   25 +
  119 files changed, 2142 insertions(+), 8712 deletions(-)
