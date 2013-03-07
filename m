From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Mar 2013 11:23:14 +0900
Subject: [GIT PULL 0/5] Samsung changes-1 for v3.10
Message-ID: <016501ce1ada$b8979e60$29c6db20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here is 1st Samsung pull-request for v3.10

This is including cleanup some header files for s3c and s5p, and samsung-timer
for s3c and s5pc100 to support clocksource/clockevent api, and irq-rework for
s3cs4xx stuff, and support pinctrl for exynos5250.

Note, you know, there are some branches in samsung tree I missed to send to
upstream last time. I'm sorting them out and as I talked to Olof before, I will
send them in early time.

If any problems, please kindly let me know.

Following is state of whole changes for this pull-requset.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next

for you to fetch changes up to d22d20e4222bc54a28e603de9ad28828bcaad812:

  Merge branch 'next/pinctrl-exynos' into for-next (2013-03-05 20:59:27 +0900)

----------------------------------------------------------------

Heiko Stuebner (16):
      ARM: S3C24XX: remove plat/irq.h in plat-samsung
      ARM: S3C24XX: move plat-samsung/s3c24XX headers to local common.h
      ARM: S3C24XX: cleanup the included soc init functions in common.h
      ARM: S3C24XX: move s3c244x irq init to common irq code
      ARM: S3C24XX: create dedicated irq init functions for s3c2440 and s3c2442
      ARM: S3C24XX: move s3c2440 irqs to common irq code
      ARM: S3C24XX: integrate s3c2440 irqs into common init
      ARM: S3C24XX: transform s3c2442 irqs into new structure
      ARM: S3C24XX: transform s3c2440 irqs into new structure
      ARM: S3C24XX: use samsung_sync_wakemask in s3c2412 pm
      ARM: S3C24XX: move s3c2412 irq init to common code
      ARM: S3C24XX: modify s3c2412 irq init to initialize all irqs
      ARM: S3C24XX: transform s3c2412 irqs into new structure
      ARM: S3C24XX: include first 4 bits of the eint register in irq mapping
      ARM: S3C24XX: add soc_is_s3c2412 option
      ARM: S3C24XX: handle s3c2412 eints using new infrastructure

Kukjin Kim (11):
      mmc: s3cmci: moved mach/regs-sdi.h into s3cmci device driver
      ARM: S3C24XX: plat/common-smdk.h local
      ARM: dts: cleanup exynos5440.dtsi
      ARM: S5PC100: remove useless ifdef in common.h
      ARM: S5PV210: remove useless ifdef in common.h
      Merge branch 'next/cleanup-s3c' into for-next
      Merge branch 'next/cleanup-s5p' into for-next
      gpio: samsung: fixes build warning with s3c2410_defconfig
      Merge branch 'next/timer-samsung' into for-next
      Merge branch 'next/irq-s3c24xx' into for-next
      Merge branch 'next/pinctrl-exynos' into for-next

Romain Naour (5):
      ARM: SAMSUNG: Rename s5p-time to samsung-time
      ARM: S3C24XX: Add samsung-time support for s3c24xx
      ARM: S3C64XX: Add samsung-time support for s3c64xx
      ARM: S5PC100: Add samsung-time support for s5pc100
      ARM: SAMSUNG: Remove unused plat-samsung/time.c

Thomas Abraham (3):
      pinctrl: exynos: add exynos5250 SoC specific data
      gpio: samsung: skip gpiolib registration if pinctrl support is enabled for
exynos5250
      ARM: EXYNOS: skip wakeup interrupt registration for exynos5250 if pinctrl
is enabled

 arch/arm/Kconfig                                   |   11 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |    5 -
 arch/arm/mach-exynos/Kconfig                       |    2 +-
 arch/arm/mach-exynos/common.c                      |    1 +
 arch/arm/mach-exynos/mach-universal_c210.c         |    6 +-
 arch/arm/mach-s3c24xx/Kconfig                      |    7 +
 arch/arm/mach-s3c24xx/Makefile                     |    6 +-
 arch/arm/mach-s3c24xx/bast-irq.c                   |    2 -
 arch/arm/mach-s3c24xx/clock-s3c2410.c              |    1 -
 arch/arm/mach-s3c24xx/clock-s3c2412.c              |    1 -
 arch/arm/mach-s3c24xx/clock-s3c2416.c              |    1 -
 arch/arm/mach-s3c24xx/clock-s3c2443.c              |    1 -
 arch/arm/mach-s3c24xx/common-smdk.c                |    3 +-
 .../include/plat => mach-s3c24xx}/common-smdk.h    |    3 +-
 arch/arm/mach-s3c24xx/common.c                     |    7 +-
 arch/arm/mach-s3c24xx/common.h                     |   93 ++++++-
 arch/arm/mach-s3c24xx/dma-s3c2410.c                |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c                |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c                |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c                |    1 -
 arch/arm/mach-s3c24xx/include/mach/irqs.h          |   58 ++--
 arch/arm/mach-s3c24xx/include/mach/regs-sdi.h      |  127 ---------
 arch/arm/mach-s3c24xx/irq-pm.c                     |    7 +-
 arch/arm/mach-s3c24xx/irq-s3c2412.c                |  215 ---------------
 arch/arm/mach-s3c24xx/irq-s3c2440.c                |  128 ---------
 arch/arm/mach-s3c24xx/irq-s3c244x.c                |  142 ----------
 arch/arm/mach-s3c24xx/irq.c                        |  272 ++++++++++++++++++-
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |    5 +-
 arch/arm/mach-s3c24xx/mach-anubis.c                |    6 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |    6 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |    4 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |    6 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |    5 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |    8 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |    6 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |    7 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |    8 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |    6 +-
 arch/arm/mach-s3c24xx/mach-otom.c                  |    5 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |    6 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |    6 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   11 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c              |    7 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |   19 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    8 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |   11 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    4 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                |    4 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |    9 +-
 arch/arm/mach-s3c24xx/pm-s3c2412.c                 |    9 +-
 arch/arm/mach-s3c24xx/s3c2410.c                    |    1 -
 arch/arm/mach-s3c24xx/s3c2412.c                    |    1 -
 arch/arm/mach-s3c24xx/s3c2416.c                    |    1 -
 arch/arm/mach-s3c24xx/s3c2440.c                    |    1 -
 arch/arm/mach-s3c24xx/s3c2442.c                    |    1 -
 arch/arm/mach-s3c24xx/s3c2443.c                    |    1 -
 arch/arm/mach-s3c24xx/s3c244x.c                    |    2 -
 arch/arm/mach-s3c64xx/Kconfig                      |    2 +
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    4 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    4 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    4 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |    2 +
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    3 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    3 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    4 +-
 arch/arm/mach-s5p64x0/Kconfig                      |    4 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    6 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    6 +-
 arch/arm/mach-s5pc100/Kconfig                      |    1 +
 arch/arm/mach-s5pc100/common.h                     |    9 -
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    4 +-
 arch/arm/mach-s5pv210/Kconfig                      |    2 +-
 arch/arm/mach-s5pv210/common.h                     |    9 -
 arch/arm/mach-s5pv210/mach-aquila.c                |    6 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |    6 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    6 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    6 +-
 arch/arm/mach-s5pv210/mach-torbreck.c              |    6 +-
 arch/arm/plat-samsung/Kconfig                      |    2 +-
 arch/arm/plat-samsung/Makefile                     |    3 +-
 arch/arm/plat-samsung/include/plat/cpu.h           |   14 +-
 arch/arm/plat-samsung/include/plat/irq.h           |  116 --------
 arch/arm/plat-samsung/include/plat/s3c2410.h       |   31 ---
 arch/arm/plat-samsung/include/plat/s3c2412.h       |   32 ---
 arch/arm/plat-samsung/include/plat/s3c2416.h       |   37 ---
 arch/arm/plat-samsung/include/plat/s3c2443.h       |   36 ---
 arch/arm/plat-samsung/include/plat/s3c244x.h       |   42 ---
 arch/arm/plat-samsung/include/plat/s5p-time.h      |   40 ---
 arch/arm/plat-samsung/include/plat/samsung-time.h  |   53 ++++
 .../plat-samsung/{s5p-time.c => samsung-time.c}    |  138 +++++-----
 arch/arm/plat-samsung/time.c                       |  287 --------------------
 drivers/gpio/gpio-samsung.c                        |    9 +-
 drivers/mmc/host/s3cmci.c                          |   83 +++++-
 drivers/pinctrl/pinctrl-exynos.c                   |  108 ++++++++
 drivers/pinctrl/pinctrl-samsung.c                  |    2 +
 drivers/pinctrl/pinctrl-samsung.h                  |    1 +
 101 files changed, 914 insertions(+), 1519 deletions(-)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c24xx}/common-smdk.h (86%)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-sdi.h
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2440.c
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c244x.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/irq.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2410.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2412.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2416.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2443.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c244x.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5p-time.h
 create mode 100644 arch/arm/plat-samsung/include/plat/samsung-time.h
 rename arch/arm/plat-samsung/{s5p-time.c => samsung-time.c} (68%)
 delete mode 100644 arch/arm/plat-samsung/time.c
