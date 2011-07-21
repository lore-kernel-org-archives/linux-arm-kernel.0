From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Jul 2011 18:51:50 +0900
Subject: [GIT PULL] Samsung S5P for v3.1 merge window
Message-ID: <001101cc478b$d48983f0$7d9c8bd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

Please pull Samsung S5P updates from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-arm-soc

Or if you want to merge each branch into arm-soc, please use following.
As per your suggestion, I made following branches in my tree...

- next-samsung-cleanup for arm-soc/next/cleanup
- next-samsung-devel for arm-soc/next/devel
- next-samsung-soc for arm-soc/next/soc (nothing)
- next-samsung-board for arm-soc/next/board
- and so on...

If any problems, please let me know.

Note: merged above branches into the for-arm-soc
- merged next-samsung-cleanup
- merged next-samsung-devel
 
Conflicts:
        arch/arm/mach-exynos4/Kconfig
        arch/arm/mach-exynos4/mach-smdkc210.c
        arch/arm/mach-s5pv210/mach-goni.c

diff --cc arch/arm/mach-exynos4/Kconfig
index ae433a0,dd8ae58..50602ef
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@@ -110,10 -122,9 +122,11 @@@ config MACH_SMDKC21
        select S3C_DEV_HSMMC1
        select S3C_DEV_HSMMC2
        select S3C_DEV_HSMMC3
 +      select SAMSUNG_DEV_PWM
 +      select SAMSUNG_DEV_BACKLIGHT
        select EXYNOS4_DEV_PD
        select EXYNOS4_DEV_SYSMMU
+       select EXYNOS4_SETUP_FIMD0
        select EXYNOS4_SETUP_I2C1
        select EXYNOS4_SETUP_SDHCI
        help
@@@ -129,11 -141,11 +143,13 @@@ config MACH_SMDKV31
        select S3C_DEV_HSMMC1
        select S3C_DEV_HSMMC2
        select S3C_DEV_HSMMC3
+       select EXYNOS4_DEV_AHCI
 +      select SAMSUNG_DEV_BACKLIGHT
        select SAMSUNG_DEV_KEYPAD
        select EXYNOS4_DEV_PD
 +      select SAMSUNG_DEV_PWM
        select EXYNOS4_DEV_SYSMMU
+       select EXYNOS4_SETUP_FIMD0
        select EXYNOS4_SETUP_I2C1
        select EXYNOS4_SETUP_KEYPAD
        select EXYNOS4_SETUP_SDHCI
diff --cc arch/arm/mach-exynos4/mach-smdkc210.c
index f606ea7,31cfcd6..a1d4eb8
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@@ -224,7 -279,7 +293,9 @@@ static void __init smdkc210_machine_ini
        s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
        s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);

 +      samsung_bl_set(&smdkc210_bl_gpio_info, &smdkc210_bl_data);
++
+       s5p_fimd0_set_platdata(&smdkc210_lcd0_pdata);

        platform_add_devices(smdkc210_devices,
ARRAY_SIZE(smdkc210_devices));
  }

- Then, finally merged next-samsung-board.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc

  Linux 3.0-rc7

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-arm-soc

Ajay Kumar (3):
      ARM: S5PC100: Cleanup mach/regs-fb.h from mach-s5pc100
      ARM: S5PV210: Cleanup mach/regs-fb.h from mach-s5pv210
      ARM: S3C64XX: Cleanup mach/regs-fb.h from mach-s3c64xx

Banajit Goswami (15):
      ARM: SAMSUNG: Create a common infrastructure for PWM backlight support
      ARM: EXYNOS4: Add PWM backlight support on SMDKV310
      ARM: EXYNOS4: Add PWM backlight support on SMDKC210
      ARM: S5PV210: Add PWM backlight support on SMDKV210
      ARM: S5PC100: Add PWM backlight support on SMDKC100
      ARM: S5P64X0: Add PWM backlight support on SMDK6440
      ARM: S5P64X0: Add PWM backlight support on SMDK6450
      ARM: S3C64XX: Add PWM backlight support on SMDK6410
      ARM: SAMSUNG: Use generic s3c_set_platdata for TS
      ARM: SAMSUNG: Use generic s3c_set_platdata for FB
      ARM: SAMSUNG: Use generic s3c_set_platdata for HWMON
      ARM: SAMSUNG: Use generic s3c_set_platdata for USB OHCI
      ARM: SAMSUNG: Use generic s3c_set_platdata for NAND
      ARM: S3C64XX: Use generic s3c_set_platdata for OneNAND
      ARM: S3C24XX: Use generic s3c_set_platdata for devices

Ben Dooks (2):
      ARM: S3C64XX: Ensure VIC based IRQs can be resumed from
      ARM: SAMSUNG: Add support for pre-sleep/post-restore gpio control

Changhwan Youn (7):
      ARM: EXYNOS4: Add external GIC io memory mapping
      ARM: EXYNOS4: modify interrupt mappings for external GIC
      ARM: EXYNOS4: set the affinity of mct1 interrupt using IRQ_MCT_L1
      ARM: GIC: move gic_chip_data structure declaration to header
      ARM: EXYNOS4: Add support external GIC
      ARM: EXYNOS4: Remove clock event timers using ARM private timers
      ARM: EXYNOS4: Add chained enrty/exit function to uart interrupt
handler

Chanwoo Choi (1):
      clocksource: convert 32-bit down counting clocksource on
S5PV210/S5P64X0

Inderpal Singh (1):
      ARM: EXYNOS4: Enable SATA on SMDKV310

Jaecheol Lee (6):
      ARM: EXYNOS4: Support system level power down configuration
      ARM: EXYNOS4: Remove PMU configuration for S2RAM
      ARM: EXYNOS4: Support early wakeup entering sleep mode
      ARM: EXYNOS4: Move S5P_CENTRAL_SEQ_CONFIGURATION setting for PM
      ARM: EXYNOS4: Add save/restore for other ARM registers
      ARM: EXYNOS4: Add save/restore function for PLL

JeongHyeon Kim (1):
      ARM: EXYNOS4: Add support for ORIGEN board

Jingoo Han (3):
      ARM: EXYNOS4: Change devname for FIMD clkdev
      ARM: EXYNOS4: Change devname for FIMD clkdev
      ARM: EXYNOS4: Add support FIMD on SMDKC210

Jonghun Han (2):
      ARM: EXYNOS4: Add resource definition for FIMD
      ARM: EXYNOS4: Add platform device and helper functions for FIMD

JungHi Min (1):
      ARM: EXYNOS4: Add support Core1 Power On/Off with hotplug in/out

Kamil Debski (3):
      ARM: S5P: Add support for MFC device
      ARM: S5PV210: Enable MFC on Goni
      ARM: EXYNOS4: Enable MFC on universal_c210

Kukjin Kim (5):
      ARM: S5P: Added selection DEV_PWM for HRT
      Merge branch 'next-samsung-clkdev-fix' into next-samsung-cleanup
      Merge branch 'next-samsung-clkdev-fix' into next-samsung-devel
      Merge branch 'next-samsung-devel' into for-next
      Merge branch 'next-samsung-board' into for-next

Marek Szyprowski (5):
      ARM: EXYNOS4: Fix compilation break
      ARM: EXYNOS4: Add FIMC device on Universal_C210
      ARM: EXYNOS4: Add MCS Touchkey device on Universal_C210
      ARM: EXYNOS4: Add qt602240 touch screen device on Universal_C210
      ARM: EXYNOS4: Enable MFC on Samsung NURI

Mark Brown (6):
      ARM: S3C64XX: Initial support for Wolfson/Simtec Cragganmore/Banff
      ARM: S3C64XX: Refresh Cragganmore support
      ARM: S3C64XX: Configure supplies for all Cragganmore regulators
      ARM: S3C64XX: Fix WM8915 IRQ polarity on Cragganmore
      ARM: S3C64XX: Configure backup battery charger on Cragganmore
      ARM: S3C64XX: Convert to using REGULATOR_SUPPLY() on SMDK6410

MyungJoo Ham (13):
      ARM: SAMSUNG: use regulator VDD for ADC
      ARM: SAMSUNG: ADC Channel selection
      ARM: SAMSUNG: Revise PM for 12-bit ADC operations
      ARM: EXYNOS4: Support ADC
      ARM: S5PV210: Support ADC
      ARM: EXYNOS4: Increase NR_IRQS for devices with more IRQs
      ARM: EXYNOS4: configure regulators and PMIC(MAX8997) on NURI
      ARM: EXYNOS4: configure MAX17042 fuel gauge on NURI
      ARM: EXYNOS4: configure ADC on NURI
      ARM: EXYNOS4: configure MAX8903 secondary charger on NURI
      ARM: EXYNOS4: configure rtc-s3c on NURI
      ARM: EXYNOS4: Add more register addresses of CMU
      ARM: EXYNOS4: Add more registers to be saved and restored for PM

Naveen Krishna Chatradhi (4):
      ARM: EXYNOS4: Add SPDIF for SMDKV310
      ARM: SAMSUNG: Use generic set_plat_data function
      ARM: SAMSUNG: Cleanup I2C code in plat-samsung
      ARM: SAMSUNG: Move duplicate code for SPDIF ops

Padmavathi Venna (1):
      ARM: S5P64X0: External Interrupt Support

Sangbeom Kim (2):
      ARM: SAMSUNG: Add platform device for idma
      ARM: SAMSUNG: Add IRQ_I2S0 definition

Seungwon Jeon (1):
      ARM: EXYNOS4: Add platform device for dwmci driver

Thomas Abraham (10):
      serial: samsung: Fix unintended usage of uart port 0 as console
      serial: Remove redundant console_initcall from s3c and s5p console
drivers
      ARM: SAMSUNG: Add clkdev infrastructure
      ARM: S3C24XX: Add clkdev support
      ARM: S3C64XX: Add clkdev support
      ARM: S5P64X0: Add clkdev support
      ARM: S5PC100: Add clkdev support
      ARM: S5PV210: Add clkdev support
      ARM: EXYNOS4: Add clkdev support
      ARM: SAMSUNG: Added mach/clkdev.h
 

 arch/arm/Kconfig                                 |   10 +
 arch/arm/common/gic.c                            |    6 -
 arch/arm/configs/exynos4_defconfig               |    1 +
 arch/arm/include/asm/hardware/gic.h              |    6 +
 arch/arm/mach-exynos4/Kconfig                    |   44 ++-
 arch/arm/mach-exynos4/Makefile                   |   12 +-
 arch/arm/mach-exynos4/clock.c                    |  238 ++++----
 arch/arm/mach-exynos4/cpu.c                      |   39 +-
 arch/arm/mach-exynos4/dev-audio.c                |    2 +
 arch/arm/mach-exynos4/dev-dwmci.c                |   82 +++
 arch/arm/mach-exynos4/hotplug.c                  |   13 +-
 arch/arm/mach-exynos4/include/mach/clkdev.h      |    7 +
 arch/arm/mach-exynos4/include/mach/dwmci.h       |   20 +
 arch/arm/mach-exynos4/include/mach/entry-macro.S |   11 +-
 arch/arm/mach-exynos4/include/mach/irqs.h        |  196 +++---
 arch/arm/mach-exynos4/include/mach/map.h         |   19 +-
 arch/arm/mach-exynos4/include/mach/pm-core.h     |   10 +
 arch/arm/mach-exynos4/include/mach/pmu.h         |   25 +
 arch/arm/mach-exynos4/include/mach/regs-audss.h  |   18 +
 arch/arm/mach-exynos4/include/mach/regs-clock.h  |   12 +
 arch/arm/mach-exynos4/include/mach/regs-pmu.h    |    1 +
 arch/arm/mach-exynos4/localtimer.c               |   26 -
 arch/arm/mach-exynos4/mach-nuri.c                |  753
+++++++++++++++++++++-
 arch/arm/mach-exynos4/mach-origen.c              |  108 +++
 arch/arm/mach-exynos4/mach-smdkc210.c            |   87 +++
 arch/arm/mach-exynos4/mach-smdkv310.c            |   19 +
 arch/arm/mach-exynos4/mach-universal_c210.c      |  121 ++++
 arch/arm/mach-exynos4/mct.c                      |    2 +-
 arch/arm/mach-exynos4/platsmp.c                  |   57 ++-
 arch/arm/mach-exynos4/pm.c                       |  275 +++++---
 arch/arm/mach-exynos4/pmu.c                      |  175 +++++
 arch/arm/mach-exynos4/setup-fimd0.c              |   43 ++
 arch/arm/mach-exynos4/time.c                     |  301 ---------
 arch/arm/mach-s3c2410/include/mach/pm-core.h     |    3 +
 arch/arm/mach-s3c2412/clock.c                    |   36 +-
 arch/arm/mach-s3c2416/clock.c                    |   10 +-
 arch/arm/mach-s3c2440/clock.c                    |    3 -
 arch/arm/mach-s3c2443/clock.c                    |   16 +-
 arch/arm/mach-s3c64xx/Kconfig                    |   24 +
 arch/arm/mach-s3c64xx/Makefile                   |    1 +
 arch/arm/mach-s3c64xx/clock.c                    |   86 +--
 arch/arm/mach-s3c64xx/dev-onenand1.c             |   10 +-
 arch/arm/mach-s3c64xx/include/mach/clkdev.h      |    7 +
 arch/arm/mach-s3c64xx/include/mach/irqs.h        |    5 +-
 arch/arm/mach-s3c64xx/include/mach/pm-core.h     |   19 +-
 arch/arm/mach-s3c64xx/include/mach/regs-fb.h     |   21 -
 arch/arm/mach-s3c64xx/irq.c                      |   12 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c             |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c            |  774
++++++++++++++++++++++
 arch/arm/mach-s3c64xx/mach-hmt.c                 |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c            |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                 |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c            |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c             |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c             |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c            |   43 +-
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c           |    1 -
 arch/arm/mach-s5p64x0/Kconfig                    |    2 +
 arch/arm/mach-s5p64x0/Makefile                   |    2 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c            |   74 +--
 arch/arm/mach-s5p64x0/clock-s5p6450.c            |   68 +--
 arch/arm/mach-s5p64x0/include/mach/clkdev.h      |    7 +
 arch/arm/mach-s5p64x0/include/mach/irqs.h        |    2 +
 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h   |   10 +
 arch/arm/mach-s5p64x0/irq-eint.c                 |  152 +++++
 arch/arm/mach-s5p64x0/mach-smdk6440.c            |   54 +--
 arch/arm/mach-s5p64x0/mach-smdk6450.c            |   54 +--
 arch/arm/mach-s5pc100/Kconfig                    |    1 +
 arch/arm/mach-s5pc100/clock.c                    |  200 ++-----
 arch/arm/mach-s5pc100/include/mach/clkdev.h      |    7 +
 arch/arm/mach-s5pc100/include/mach/regs-fb.h     |  105 ---
 arch/arm/mach-s5pc100/mach-smdkc100.c            |   57 +--
 arch/arm/mach-s5pc100/setup-fb-24bpp.c           |    1 -
 arch/arm/mach-s5pv210/Kconfig                    |    2 +
 arch/arm/mach-s5pv210/clock.c                    |  174 ++----
 arch/arm/mach-s5pv210/cpu.c                      |    2 +-
 arch/arm/mach-s5pv210/dev-audio.c                |    2 +
 arch/arm/mach-s5pv210/include/mach/clkdev.h      |    7 +
 arch/arm/mach-s5pv210/include/mach/map.h         |    3 +
 arch/arm/mach-s5pv210/include/mach/pm-core.h     |    3 +
 arch/arm/mach-s5pv210/include/mach/regs-audss.h  |   18 +
 arch/arm/mach-s5pv210/include/mach/regs-fb.h     |   21 -
 arch/arm/mach-s5pv210/mach-aquila.c              |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c                |   12 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c            |   57 +--
 arch/arm/mach-s5pv210/setup-fb-24bpp.c           |    1 -
 arch/arm/plat-s3c24xx/clock-dclk.c               |    4 -
 arch/arm/plat-s3c24xx/devs.c                     |   38 +-
 arch/arm/plat-s3c24xx/include/mach/clkdev.h      |    7 +
 arch/arm/plat-s3c24xx/s3c2410-clock.c            |   21 +-
 arch/arm/plat-s3c24xx/s3c2443-clock.c            |   39 +-
 arch/arm/plat-s5p/Kconfig                        |   11 +
 arch/arm/plat-s5p/Makefile                       |    3 +-
 arch/arm/plat-s5p/clock.c                        |   35 +
 arch/arm/plat-s5p/dev-fimd0.c                    |   67 ++
 arch/arm/plat-s5p/dev-mfc.c                      |  123 ++++
 arch/arm/plat-s5p/include/plat/map-s5p.h         |    5 +-
 arch/arm/plat-s5p/include/plat/mfc.h             |   27 +
 arch/arm/plat-s5p/include/plat/s5p-clock.h       |    5 +
 arch/arm/plat-s5p/s5p-time.c                     |   29 +-
 arch/arm/plat-samsung/Kconfig                    |    6 +
 arch/arm/plat-samsung/Makefile                   |    1 +
 arch/arm/plat-samsung/adc.c                      |   84 ++-
 arch/arm/plat-samsung/clock.c                    |   98 +---
 arch/arm/plat-samsung/dev-asocdma.c              |   10 +
 arch/arm/plat-samsung/dev-backlight.c            |  149 +++++
 arch/arm/plat-samsung/dev-fb.c                   |   14 +-
 arch/arm/plat-samsung/dev-hwmon.c                |   14 +-
 arch/arm/plat-samsung/dev-i2c0.c                 |   14 +-
 arch/arm/plat-samsung/dev-i2c1.c                 |   24 +-
 arch/arm/plat-samsung/dev-i2c2.c                 |   24 +-
 arch/arm/plat-samsung/dev-i2c3.c                 |   24 +-
 arch/arm/plat-samsung/dev-i2c4.c                 |   24 +-
 arch/arm/plat-samsung/dev-i2c5.c                 |   24 +-
 arch/arm/plat-samsung/dev-i2c6.c                 |   24 +-
 arch/arm/plat-samsung/dev-i2c7.c                 |   24 +-
 arch/arm/plat-samsung/dev-nand.c                 |    9 +-
 arch/arm/plat-samsung/dev-ts.c                   |   14 +-
 arch/arm/plat-samsung/dev-usb.c                  |    9 +-
 arch/arm/plat-samsung/include/plat/audio.h       |    1 +
 arch/arm/plat-samsung/include/plat/backlight.h   |   26 +
 arch/arm/plat-samsung/include/plat/clock.h       |    3 +
 arch/arm/plat-samsung/include/plat/devs.h        |    6 +
 arch/arm/plat-samsung/include/plat/fb-core.h     |   15 +
 arch/arm/plat-samsung/include/plat/fb.h          |   15 +
 arch/arm/plat-samsung/include/plat/iic.h         |    2 +
 arch/arm/plat-samsung/include/plat/regs-adc.h    |    1 +
 arch/arm/plat-samsung/irq-uart.c                 |    7 +
 arch/arm/plat-samsung/pm.c                       |    2 +
 arch/arm/plat-samsung/pwm-clock.c                |   10 +
 arch/arm/plat-samsung/time.c                     |    2 +
 drivers/tty/serial/s3c2410.c                     |    2 -
 drivers/tty/serial/s3c2412.c                     |    2 -
 drivers/tty/serial/s3c2440.c                     |    2 -
 drivers/tty/serial/s3c6400.c                     |    2 -
 drivers/tty/serial/s5pv210.c                     |    7 -
 drivers/tty/serial/samsung.c                     |    9 +-
 drivers/tty/serial/samsung.h                     |   19 -
 138 files changed, 4077 insertions(+), 1984 deletions(-)
