From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Mar 2011 22:57:35 +0900
Subject: [GIT PULL] Samsung S5P for 2.6.39 merge window
Message-ID: <011d01cbe318$f28d2e10$d7a78a30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull Samsung S5P updates from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

These things are for 2.6.39.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit a5abba989deceb731047425812d268daf7536575

  Linux 2.6.38-rc8

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

ALIM AKHTAR (1):
      ARM: EXYNOS4: Add ARMLEX4210 Board support file

Abhilash Kesavan (1):
      ARM: EXYNOS4: Add support for SATA on ARMLEX4210

Banajit Goswami (6):
      ARM: SAMSUNG: Move PWM device definition from plat-s3c24xx to
plat-samsung
      ARM: SAMSUNG: Add PWM backlight support on Samsung S3C6410
      ARM: SAMSUNG: Add PWM backlight support on Samsung S5P6440
      ARM: SAMSUNG: Add PWM backlight support on Samsung S5P6450
      ARM: SAMSUNG: Add PWM backlight support on Samsung S5PC100
      ARM: SAMSUNG: Add PWM backlight support on Samsung S5PV210

Changhwan Youn (3):
      ARM: EXYNOS4: Add SYSTIMER IO Address mapping for MCT
      ARM: EXYNOS4: Add irq definition for kernel global timer
      ARM: EXYNOS4: Implement kernel timers using MCT

Donghwa Lee (1):
      ARM: EXYNOS4: enabled lcd and backlight in NURI board

Inderpal Singh (1):
      ARM: EXYNOS4: Enable watchdog parent clock

Jaecheol Lee (3):
      ARM: EXYNOS4: Add PMU and CMU Registers for PM
      ARM: EXYNOS4: Suspend to RAM Support
      ARM: EXYNOS4: Update HRT for supporting PM

Kukjin Kim (19):
      ARM: S5PV210: Use REGULATOR_SUPPLY macro for regulator consumers
      ARM: EXYNOS4: Add EXYNOS4 CPU initialization support
      ARM: EXYNOS4: Update Clock part
      ARM: EXYNOS4: Update IRQ part
      ARM: EXYNOS4: Update Timer part
      ARM: EXYNOS4: Update device support
      ARM: EXYNOS4: Moved board support files
      ARM: EXYNOS4: Update Kconfig and Makefile for the new ARCH_EXYNOS4
      ARM: exynos4_defconfig: Add defconfig for EXYNOS4
      mtd: OneNAND: Change dependency of ARCH_EXYNOS4
      ASoC: Change dependency of ARCH_EXYNOS4
      tty: Change dependency of ARCH_EXYNOS4
      ARM: EXYNOS4: Fix wrong constants in the hotplug assembly code.
      Merge branch 'next-exynos4' into for-next
      Merge branch 'next-s5p' into for-next
      Merge branch 'next-s3c2440-gta02' into for-next
      Merge branch 'dev/pwm-backlight' into for-next
      Merge branch 'next-exynos4' into next-exynos4-pm
      Merge branch 'next-exynos4-pm' into for-next

KyongHo Cho (2):
      ARM: EXYNOS4: Enhancement of System MMU driver
      ARM: EXYNOS4: Implement Clock gating for System MMU

Kyungmin Park (1):
      ARM: EXYNOS4: Remove meaningless REGULATOR config option

Lars-Peter Clausen (6):
      ARM: S3C2440: Register PCM device on GTA02
      ARM: S3C2440: Add button support on GTA02
      ARM: S3C2440: Fix regulator valid_modes_ops on GTA02
      ARM: S3C2440: Call regulator_has_full_constraints on GTA02
      ARM: S3C2440: Remove state_mem constraints for the pcf50633 regulators
on GTA02
      ARM: S3C2440: Add touchscreen support on GTA02

Marek Szyprowski (7):
      ARM: S5PV210: Disable unused power regulators on GONI board
      ARM: S5PV210: Add power consumers for hsotg for GONI board
      ARM: EXYNOS4: Add support for i2c PMICs on Universal_C210 board
      ARM: EXYNOS4: Add missing GPYx banks
      ARM: S5P: Cleanup S5P gpio interrupt code
      ARM: S5P: Add function to register gpio interrupt bank data
      ARM: EXYNOS4: Add support for gpio interrupts

Mark Brown (1):
      ARM: S3C64XX: Fix section mismatch from cpufreq init

Minkyu Kang (1):
      ARM: EXYNOS4: Adds Samsung NURI board support

Naveen Krishna Ch (4):
      ARM: EXYNOS4: Add keypad device helpers
      ARM: EXYNOS4: Update keypad base address
      ARM: EXYNOS4: Update clocks for keypad
      ARM: EXYNOS4: Add keypad device to the SMDKV310

Sangbeom Kim (3):
      ARM: S5P: HRT support
      ARM: S5P: Update machine of S5P64X0 and S5PV210 for HRT
      ARM: S5P: Update defconfig for HRT support

Seungwhan Youn (1):
      ARM: EXYNOS4: Debug wrong S/PDIF register address

Sylwester Nawrocki (8):
      ARM: S5PV210: Enable I2C0 bus on GONI board
      ARM: S5PV210: Add supplies for CIF camera on GONI board
      ARM: S5PV210: Change framebuffer window 0 size on GONI
      ARM: S5P: Add platform helpers for camera GPIO configuration
      ARM: S5P: Rename MIPI-CSIS driver header and update Copyright
      ARM: S5P: Extend MIPI-CSIS platform_data with the PHY control callback
      ARM: S5P: Add support for common MIPI CSIS/DSIM D-PHY control
      ARM: S5P: Add platform definitions for FIMC3

 arch/arm/Kconfig                                   |   20 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/configs/exynos4_defconfig                 |   70 +++
 arch/arm/configs/s5p64x0_defconfig                 |    2 +
 arch/arm/configs/s5pv210_defconfig                 |    2 +
 arch/arm/mach-exynos4/Kconfig                      |  195 ++++++
 arch/arm/mach-exynos4/Makefile                     |   56 ++
 .../{mach-s5pv310 => mach-exynos4}/Makefile.boot   |    0
 arch/arm/{mach-s5pv310 => mach-exynos4}/clock.c    |  286 ++++++---
 arch/arm/{mach-s5pv310 => mach-exynos4}/cpu.c      |   99 ++--
 arch/arm/{mach-s5pv310 => mach-exynos4}/cpufreq.c  |  110 ++--
 arch/arm/mach-exynos4/dev-ahci.c                   |  263 ++++++++
 .../arm/{mach-s5pv310 => mach-exynos4}/dev-audio.c |  143 +++---
 arch/arm/{mach-s5pv310 => mach-exynos4}/dev-pd.c   |   40 +-
 .../{mach-s5pv310 => mach-exynos4}/dev-sysmmu.c    |  121 +++--
 arch/arm/{mach-s5pv310 => mach-exynos4}/dma.c      |   50 +-
 arch/arm/mach-exynos4/gpiolib.c                    |  365 +++++++++++
 arch/arm/{mach-s5pv310 => mach-exynos4}/headsmp.S  |    6 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/hotplug.c  |   10 +-
 .../include/mach/debug-macro.S                     |    6 +-
 .../include/mach/dma.h                             |    0
 .../include/mach/entry-macro.S                     |    4 +-
 arch/arm/mach-exynos4/include/mach/gpio.h          |  156 +++++
 .../include/mach/hardware.h                        |    8 +-
 .../include/mach/io.h                              |    8 +-
 .../include/mach/irqs.h                            |   26 +-
 arch/arm/mach-exynos4/include/mach/map.h           |  162 +++++
 .../include/mach/memory.h                          |    8 +-
 arch/arm/mach-exynos4/include/mach/pm-core.h       |   49 ++
 .../include/mach/pwm-clock.h                       |    8 +-
 .../include/mach/regs-clock.h                      |   41 +-
 arch/arm/mach-exynos4/include/mach/regs-gpio.h     |   42 ++
 .../include/mach/regs-irq.h                        |    8 +-
 arch/arm/mach-exynos4/include/mach/regs-mct.h      |   52 ++
 .../include/mach/regs-mem.h                        |    6 +-
 arch/arm/mach-exynos4/include/mach/regs-pmu.h      |  162 +++++
 .../include/mach/regs-sysmmu.h                     |   10 +-
 .../include/mach/smp.h                             |    2 +-
 arch/arm/mach-exynos4/include/mach/sysmmu.h        |   46 ++
 .../include/mach/system.h                          |    8 +-
 .../include/mach/timex.h                           |    8 +-
 .../include/mach/uncompress.h                      |    8 +-
 .../include/mach/vmalloc.h                         |    8 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/init.c     |   10 +-
 .../{mach-s5pv310 => mach-exynos4}/irq-combiner.c  |    4 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/irq-eint.c |   62 +-
 .../{mach-s5pv310 => mach-exynos4}/localtimer.c    |    2 +-
 arch/arm/mach-exynos4/mach-armlex4210.c            |  215 +++++++
 arch/arm/mach-exynos4/mach-nuri.c                  |  305 +++++++++
 .../{mach-s5pv310 => mach-exynos4}/mach-smdkc210.c |   48 +-
 .../{mach-s5pv310 => mach-exynos4}/mach-smdkv310.c |   72 ++-
 arch/arm/mach-exynos4/mach-universal_c210.c        |  650
++++++++++++++++++++
 arch/arm/mach-exynos4/mct.c                        |  421 +++++++++++++
 arch/arm/{mach-s5pv310 => mach-exynos4}/platsmp.c  |   12 +-
 arch/arm/mach-exynos4/pm.c                         |  420 +++++++++++++
 arch/arm/mach-exynos4/setup-fimc.c                 |   44 ++
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c0.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c1.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c2.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c3.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c4.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c5.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c6.c    |    4 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c7.c    |    4 +-
 arch/arm/mach-exynos4/setup-keypad.c               |   35 +
 .../setup-sdhci-gpio.c                             |   52 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-sdhci.c   |   12 +-
 arch/arm/mach-exynos4/sleep.S                      |   76 +++
 arch/arm/{mach-s5pv310 => mach-exynos4}/time.c     |   80 ++-
 arch/arm/mach-s3c2440/mach-gta02.c                 |   71 ++-
 arch/arm/mach-s3c64xx/Kconfig                      |    5 +-
 arch/arm/mach-s3c64xx/cpufreq.c                    |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   46 ++-
 arch/arm/mach-s5p64x0/Kconfig                      |    4 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |   47 ++-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |   47 ++-
 arch/arm/mach-s5pc100/Kconfig                      |    1 +
 arch/arm/mach-s5pc100/gpiolib.c                    |    1 +
 arch/arm/mach-s5pc100/mach-smdkc100.c              |   48 ++-
 arch/arm/mach-s5pv210/Kconfig                      |    7 +
 arch/arm/mach-s5pv210/Makefile                     |    1 +
 arch/arm/mach-s5pv210/gpiolib.c                    |    1 +
 arch/arm/mach-s5pv210/include/mach/regs-clock.h    |    5 +-
 arch/arm/mach-s5pv210/mach-aquila.c                |   56 +--
 arch/arm/mach-s5pv210/mach-goni.c                  |  107 ++--
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    4 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |   47 ++-
 arch/arm/mach-s5pv210/mach-torbreck.c              |    4 +-
 arch/arm/mach-s5pv210/setup-fimc.c                 |   43 ++
 arch/arm/mach-s5pv310/Kconfig                      |  151 -----
 arch/arm/mach-s5pv310/Makefile                     |   43 --
 arch/arm/mach-s5pv310/gpiolib.c                    |  304 ---------
 arch/arm/mach-s5pv310/include/mach/gpio.h          |  135 ----
 arch/arm/mach-s5pv310/include/mach/map.h           |  144 -----
 arch/arm/mach-s5pv310/include/mach/regs-gpio.h     |   42 --
 arch/arm/mach-s5pv310/include/mach/regs-pmu.h      |   30 -
 arch/arm/mach-s5pv310/include/mach/sysmmu.h        |  122 ----
 arch/arm/mach-s5pv310/mach-universal_c210.c        |  237 -------
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-s3c24xx/Kconfig                      |    7 -
 arch/arm/plat-s5p/Kconfig                          |   23 +-
 arch/arm/plat-s5p/Makefile                         |    3 +
 arch/arm/plat-s5p/cpu.c                            |   25 +-
 arch/arm/plat-s5p/dev-csis0.c                      |    2 +-
 arch/arm/plat-s5p/dev-csis1.c                      |    2 +-
 arch/arm/plat-s5p/dev-fimc3.c                      |   43 ++
 arch/arm/plat-s5p/include/plat/camport.h           |   28 +
 arch/arm/plat-s5p/include/plat/csis.h              |   28 -
 arch/arm/plat-s5p/include/plat/exynos4.h           |   34 +
 arch/arm/plat-s5p/include/plat/mipi_csis.h         |   43 ++
 arch/arm/plat-s5p/include/plat/s5p-time.h          |   40 ++
 arch/arm/plat-s5p/include/plat/s5pv310.h           |   34 -
 arch/arm/plat-s5p/include/plat/sysmmu.h            |   95 +++
 arch/arm/plat-s5p/irq-gpioint.c                    |  170 +++--
 arch/arm/plat-s5p/s5p-time.c                       |  448 ++++++++++++++
 arch/arm/plat-s5p/setup-mipiphy.c                  |   63 ++
 arch/arm/plat-s5p/sysmmu.c                         |  370 ++++++------
 arch/arm/plat-samsung/Kconfig                      |   13 +
 arch/arm/plat-samsung/Makefile                     |    1 +
 arch/arm/plat-samsung/dev-pwm.c                    |   53 ++
 arch/arm/plat-samsung/include/plat/cpu.h           |    1 +
 arch/arm/plat-samsung/include/plat/devs.h          |   25 +-
 arch/arm/plat-samsung/include/plat/fimc-core.h     |    5 +
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      |   16 +
 arch/arm/plat-samsung/include/plat/pd.h            |    4 +-
 arch/arm/plat-samsung/include/plat/sdhci.h         |   63 +-
 arch/arm/plat-samsung/pwm.c                        |   33 -
 drivers/mtd/onenand/Kconfig                        |    2 +-
 drivers/tty/serial/Kconfig                         |    4 +-
 sound/soc/samsung/Kconfig                          |    2 +-
 130 files changed, 6308 insertions(+), 2357 deletions(-)
