From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Feb 2013 15:42:00 -0800
Subject: [GIT PULL 4/5] Samsung cleanup-s3c24xx-2 for v3.9
Message-ID: <120e01ce0331$3aba1ec0$b02e5c40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

This is 4th cleanup for Samsung S3C24XX stuff, and removes plat-s3c24xx
directory :-)
Note, this is based on previous pull-request, 'next/irq-s3c24xx' branch.

If any problems, please kindly let me know.

Thanks.

- Kukjin


The following changes since commit f44ddba3635e35317057e976888d4a12dcb0f842:

  ARM: S3C24XX: transform s3c2443 subirqs into new structure (2013-02-03
15:52:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/cleanup-s3c24xx-2

for you to fetch changes up to 37c3adca81b282bdf310d5ed54acbc28ac0b20a3:

  ARM: S3C24XX: header mach/regs-mem.h local (2013-02-04 10:31:43 -0800)

----------------------------------------------------------------
Kukjin Kim (4):
      ARM: S3C24XX: Remove plat-s3c24xx directory in arch/arm/
      ARM: S3C24XX: header mach/regs-s3c2412-mem.h local
      ARM: S3C24XX: header mach/regs-power.h local
      ARM: S3C24XX: header mach/regs-mem.h local

 arch/arm/Kconfig
|    1 -
 arch/arm/Makefile
|    2 +-
 arch/arm/mach-s3c24xx/Kconfig
|  104 ++++++++++++++++++++++++++++
 arch/arm/mach-s3c24xx/Makefile
|   14 +++-
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/clock-dclk.c
|    3 +-
 arch/arm/{plat-s3c24xx/s3c2410-clock.c => mach-s3c24xx/clock-s3c2410.c}
|    3 +-
 arch/arm/{plat-s3c24xx/cpu-freq-debugfs.c =>
mach-s3c24xx/cpufreq-debugfs.c}    |    3 +-
 arch/arm/mach-s3c24xx/cpufreq-s3c2412.c
|    3 +-
 arch/arm/{plat-s3c24xx/s3c2410-cpufreq-utils.c =>
mach-s3c24xx/cpufreq-utils.c} |    6 +-
 arch/arm/{plat-s3c24xx/cpu-freq.c => mach-s3c24xx/cpufreq.c}
|    3 +-
 arch/arm/mach-s3c24xx/dma-s3c2410.c
|    1 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c
|    1 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c
|    1 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c
|    1 -
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/dma.c
|    3 +-
 arch/arm/mach-s3c24xx/include/mach/regs-mem.h
|  202 ------------------------------------------------------
 arch/arm/mach-s3c24xx/include/mach/regs-power.h
|   40 -----------
 arch/arm/mach-s3c24xx/include/mach/regs-s3c2412-mem.h
|   48 -------------
 arch/arm/{plat-s3c24xx/s3c2410-iotiming.c =>
mach-s3c24xx/iotiming-s3c2410.c}   |    6 +-
 arch/arm/{plat-s3c24xx/s3c2412-iotiming.c =>
mach-s3c24xx/iotiming-s3c2412.c}   |    7 +-
 arch/arm/mach-s3c24xx/irq-s3c2412.c
|    3 +-
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq.c
|    0
 arch/arm/mach-s3c24xx/mach-anubis.c
|    1 -
 arch/arm/mach-s3c24xx/mach-at2440evb.c
|    1 -
 arch/arm/mach-s3c24xx/mach-bast.c
|    1 -
 arch/arm/mach-s3c24xx/mach-gta02.c
|    1 -
 arch/arm/mach-s3c24xx/mach-jive.c
|    4 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c
|    1 -
 arch/arm/mach-s3c24xx/mach-osiris.c
|    2 +-
 arch/arm/mach-s3c24xx/pm-s3c2412.c
|    2 +-
 arch/arm/mach-s3c24xx/pm-s3c2416.c
|    3 +-
 arch/arm/mach-s3c24xx/pm.c
|    3 +-
 arch/arm/mach-s3c24xx/regs-mem.h
|   54 +++++++++++++++
 arch/arm/mach-s3c24xx/s3c2412-power.h
|   37 ++++++++++
 arch/arm/mach-s3c24xx/s3c2412.c
|    2 +-
 arch/arm/mach-s3c24xx/s3c2412.h
|   26 +++++++
 arch/arm/mach-s3c24xx/simtec-pm.c
|    3 +-
 arch/arm/mach-s3c24xx/sleep-s3c2410.S
|    3 +-
 arch/arm/mach-s3c24xx/sleep.S
|    1 -
 arch/arm/plat-s3c24xx/Kconfig
|  117 -------------------------------
 arch/arm/plat-s3c24xx/Makefile
|   27 --------
 41 files changed, 266 insertions(+), 478 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/clock-dclk.c (98%)
 rename arch/arm/{plat-s3c24xx/s3c2410-clock.c =>
mach-s3c24xx/clock-s3c2410.c} (99%)
 rename arch/arm/{plat-s3c24xx/cpu-freq-debugfs.c =>
mach-s3c24xx/cpufreq-debugfs.c} (98%)
 rename arch/arm/{plat-s3c24xx/s3c2410-cpufreq-utils.c =>
mach-s3c24xx/cpufreq-utils.c} (95%)
 rename arch/arm/{plat-s3c24xx/cpu-freq.c => mach-s3c24xx/cpufreq.c} (99%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/dma.c (99%)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-mem.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-power.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-s3c2412-mem.h
 rename arch/arm/{plat-s3c24xx/s3c2410-iotiming.c =>
mach-s3c24xx/iotiming-s3c2410.c} (99%)
 rename arch/arm/{plat-s3c24xx/s3c2412-iotiming.c =>
mach-s3c24xx/iotiming-s3c2412.c} (98%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq.c (100%)
 create mode 100644 arch/arm/mach-s3c24xx/regs-mem.h
 create mode 100644 arch/arm/mach-s3c24xx/s3c2412-power.h
 create mode 100644 arch/arm/mach-s3c24xx/s3c2412.h
 delete mode 100644 arch/arm/plat-s3c24xx/Kconfig
 delete mode 100644 arch/arm/plat-s3c24xx/Makefile
