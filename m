From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:24 +0900
Subject: [PATCH 00/12] ARM: restart: SAMSUNG: use new restart hook
Message-ID: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces common.[ch] in each SAMSUNG mach- directories
and implements using new restart hook for Samsung stuff.

This is against on rmk/devel-stable branch.

[PATCH 01/12] ARM: S3C64XX: introduce arch/arm/mach-s3c64xx/common.[ch]
[PATCH 02/12] ARM: restart: S3C64XX: use new restart hook
[PATCH 03/12] ARM: S5P64X0: introduce arch/arm/mach-s5p64x0/common.[ch]
[PATCH 04/12] ARM: restart: S5P64X0: use new restart hook
[PATCH 05/12] ARM: S5PC100: introduce arch/arm/mach-s5pc100/common.[ch]
[PATCH 06/12] ARM: restart: S5PC100: use new restart hook
[PATCH 07/12] ARM: S5PV210: introduce arch/arm/mach-s5pv210/common.[ch]
[PATCH 08/12] ARM: restart: S5PV210: use new restart hook
[PATCH 09/12] ARM: EXYNOS: introduce arch/arm/mach-exynos/common.[ch]
[PATCH 10/12] ARM: restart: EXYNOS: use new restart hook
[PATCH 11/12] ARM: restart: S3C24XX: move SWRST based S3C platforms
[PATCH 12/12] ARM: restart: S3C24XX: use new restart hook

---

The following changes since commit 3bdc3484e8f2b1b219ad0397d81ce4601fbaf76d:

  ARM: kexec: use soft_restart for branching to the reboot buffer (2011-12-12 16:07:36 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git next/rmk-restart

Heiko Stuebner (1):
      ARM: restart: S3C24XX: move SWRST based S3C platforms to machine_desc hook

Kukjin Kim (9):
      ARM: S3C64XX: introduce arch/arm/mach-s3c64xx/common.[ch]
      ARM: restart: S3C64XX: use new restart hook
      ARM: S5P64X0: introduce arch/arm/mach-s5p64x0/common.[ch]
      ARM: restart: S5P64X0: use new restart hook
      ARM: S5PC100: introduce arch/arm/mach-s5pc100/common.[ch]
      ARM: restart: S5PC100: use new restart hook
      ARM: S5PV210: introduce arch/arm/mach-s5pv210/common.[ch]
      ARM: EXYNOS: introduce arch/arm/mach-exynos/common.[ch]
      ARM: restart: S3C24XX: use new restart hook

Russell King (2):
      ARM: restart: S5PV210: use new restart hook
      ARM: restart: EXYNOS: use new restart hook

 arch/arm/mach-exynos/Makefile                      |    9 +-
 arch/arm/mach-exynos/clock-exynos4210.c            |    3 +-
 arch/arm/mach-exynos/clock-exynos4212.c            |    3 +-
 arch/arm/mach-exynos/clock.c                       |    3 +-
 arch/arm/mach-exynos/common.c                      |  704 ++++++++++++++++++++
 arch/arm/mach-exynos/common.h                      |   41 ++
 arch/arm/mach-exynos/cpu.c                         |  284 --------
 arch/arm/mach-exynos/include/mach/map.h            |   12 +-
 arch/arm/mach-exynos/include/mach/system.h         |    2 -
 arch/arm/mach-exynos/init.c                        |   42 --
 arch/arm/mach-exynos/irq-combiner.c                |  124 ----
 arch/arm/mach-exynos/irq-eint.c                    |  237 -------
 arch/arm/mach-exynos/mach-armlex4210.c             |    6 +-
 arch/arm/mach-exynos/mach-nuri.c                   |    6 +-
 arch/arm/mach-exynos/mach-origen.c                 |    6 +-
 arch/arm/mach-exynos/mach-smdk4x12.c               |    7 +-
 arch/arm/mach-exynos/mach-smdkv310.c               |    7 +-
 arch/arm/mach-exynos/mach-universal_c210.c         |    6 +-
 arch/arm/mach-s3c2410/common.h                     |   17 +
 arch/arm/mach-s3c2410/include/mach/reset.h         |   22 -
 arch/arm/mach-s3c2410/include/mach/system-reset.h  |   32 -
 arch/arm/mach-s3c2410/include/mach/system.h        |    4 -
 arch/arm/mach-s3c2410/mach-amlm5900.c              |    3 +
 arch/arm/mach-s3c2410/mach-bast.c                  |    2 +
 arch/arm/mach-s3c2410/mach-h1940.c                 |    3 +
 arch/arm/mach-s3c2410/mach-n30.c                   |    4 +
 arch/arm/mach-s3c2410/mach-otom.c                  |    3 +
 arch/arm/mach-s3c2410/mach-qt2410.c                |    5 +-
 arch/arm/mach-s3c2410/mach-smdk2410.c              |    5 +-
 arch/arm/mach-s3c2410/mach-tct_hammer.c            |    3 +
 arch/arm/mach-s3c2410/mach-vr1000.c                |    2 +
 arch/arm/mach-s3c2410/s3c2410.c                    |    9 +
 arch/arm/mach-s3c2412/mach-jive.c                  |    2 +
 arch/arm/mach-s3c2412/mach-smdk2413.c              |    3 +
 arch/arm/mach-s3c2412/mach-vstms.c                 |    1 +
 arch/arm/mach-s3c2412/s3c2412.c                    |   10 +-
 arch/arm/mach-s3c2416/mach-smdk2416.c              |    1 +
 arch/arm/mach-s3c2416/s3c2416.c                    |    7 +-
 arch/arm/mach-s3c2440/common.h                     |   17 +
 arch/arm/mach-s3c2440/mach-anubis.c                |    3 +
 arch/arm/mach-s3c2440/mach-at2440evb.c             |    3 +
 arch/arm/mach-s3c2440/mach-gta02.c                 |    2 +
 arch/arm/mach-s3c2440/mach-mini2440.c              |    3 +
 arch/arm/mach-s3c2440/mach-nexcoder.c              |    3 +
 arch/arm/mach-s3c2440/mach-osiris.c                |    3 +
 arch/arm/mach-s3c2440/mach-rx1950.c                |    3 +
 arch/arm/mach-s3c2440/mach-rx3715.c                |    3 +
 arch/arm/mach-s3c2440/mach-smdk2440.c              |    3 +
 arch/arm/mach-s3c2440/s3c2440.c                    |    9 +
 arch/arm/mach-s3c2443/mach-smdk2443.c              |    1 +
 arch/arm/mach-s3c2443/s3c2443.c                    |    8 +-
 arch/arm/mach-s3c64xx/Makefile                     |   65 +-
 arch/arm/mach-s3c64xx/clock.c                      |    4 +-
 arch/arm/mach-s3c64xx/{irq-eint.c => common.c}     |  192 +++++-
 arch/arm/mach-s3c64xx/common.h                     |   57 ++
 arch/arm/mach-s3c64xx/cpu.c                        |  161 -----
 arch/arm/mach-s3c64xx/include/mach/system.h        |   11 -
 arch/arm/mach-s3c64xx/irq.c                        |   47 --
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
 arch/arm/mach-s3c64xx/s3c6400.c                    |    5 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |    6 +-
 arch/arm/mach-s5p64x0/Makefile                     |    9 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |    3 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |    3 +-
 arch/arm/mach-s5p64x0/clock.c                      |    4 +-
 arch/arm/mach-s5p64x0/common.c                     |  468 +++++++++++++
 arch/arm/mach-s5p64x0/common.h                     |   57 ++
 arch/arm/mach-s5p64x0/cpu.c                        |  215 ------
 arch/arm/mach-s5p64x0/include/mach/system.h        |    2 -
 arch/arm/mach-s5p64x0/init.c                       |   73 --
 arch/arm/mach-s5p64x0/irq-eint.c                   |  155 -----
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    6 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    6 +-
 arch/arm/mach-s5pc100/Makefile                     |   29 +-
 arch/arm/mach-s5pc100/clock.c                      |    3 +-
 arch/arm/mach-s5pc100/{cpu.c => common.c}          |  103 +++-
 arch/arm/mach-s5pc100/common.h                     |   37 +
 arch/arm/mach-s5pc100/include/mach/system.h        |    2 -
 arch/arm/mach-s5pc100/init.c                       |   24 -
 arch/arm/mach-s5pv210/common.h                     |   37 +
 arch/arm/mach-s5pv210/include/mach/system.h        |    2 -
 arch/arm/mach-s5pv210/init.c                       |   44 --
 arch/arm/mach-s5pv210/mach-aquila.c                |    6 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |    6 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    6 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    6 +-
 arch/arm/mach-s5pv210/mach-torbreck.c              |    6 +-
 arch/arm/plat-s3c24xx/cpu.c                        |    2 -
 arch/arm/plat-s5p/Makefile                         |    1 -
 arch/arm/plat-s5p/cpu.c                            |  144 ----
 arch/arm/plat-samsung/include/plat/cpu.h           |    6 -
 arch/arm/plat-samsung/include/plat/exynos4.h       |   35 -
 arch/arm/plat-samsung/include/plat/reset.h         |   16 -
 arch/arm/plat-samsung/include/plat/s3c2412.h       |    3 +
 arch/arm/plat-samsung/include/plat/s3c2416.h       |    2 +
 arch/arm/plat-samsung/include/plat/s3c2443.h       |    2 +
 arch/arm/plat-samsung/include/plat/s3c6400.h       |   36 -
 arch/arm/plat-samsung/include/plat/s3c6410.h       |   29 -
 arch/arm/plat-samsung/include/plat/s5p6440.h       |   36 -
 arch/arm/plat-samsung/include/plat/s5p6450.h       |   36 -
 arch/arm/plat-samsung/include/plat/s5pc100.h       |   33 -
 arch/arm/plat-samsung/include/plat/s5pv210.h       |   33 -
 arch/arm/plat-samsung/include/plat/system-reset.h  |   31 -
 .../arm/plat-samsung/include/plat/watchdog-reset.h |    1 +
 118 files changed, 2072 insertions(+), 2116 deletions(-)
 create mode 100644 arch/arm/mach-exynos/common.c
 create mode 100644 arch/arm/mach-exynos/common.h
 delete mode 100644 arch/arm/mach-exynos/cpu.c
 delete mode 100644 arch/arm/mach-exynos/init.c
 delete mode 100644 arch/arm/mach-exynos/irq-combiner.c
 delete mode 100644 arch/arm/mach-exynos/irq-eint.c
 create mode 100644 arch/arm/mach-s3c2410/common.h
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/reset.h
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/system-reset.h
 create mode 100644 arch/arm/mach-s3c2440/common.h
 rename arch/arm/mach-s3c64xx/{irq-eint.c => common.c} (50%)
 create mode 100644 arch/arm/mach-s3c64xx/common.h
 delete mode 100644 arch/arm/mach-s3c64xx/cpu.c
 delete mode 100644 arch/arm/mach-s3c64xx/irq.c
 create mode 100644 arch/arm/mach-s5p64x0/common.c
 create mode 100644 arch/arm/mach-s5p64x0/common.h
 delete mode 100644 arch/arm/mach-s5p64x0/cpu.c
 delete mode 100644 arch/arm/mach-s5p64x0/init.c
 delete mode 100644 arch/arm/mach-s5p64x0/irq-eint.c
 rename arch/arm/mach-s5pc100/{cpu.c => common.c} (66%)
 create mode 100644 arch/arm/mach-s5pc100/common.h
 delete mode 100644 arch/arm/mach-s5pc100/init.c
 rename arch/arm/mach-s5pv210/{cpu.c => common.c} (67%)
 create mode 100644 arch/arm/mach-s5pv210/common.h
 delete mode 100644 arch/arm/mach-s5pv210/init.c
 delete mode 100644 arch/arm/plat-s5p/cpu.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/exynos4.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/reset.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c6400.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c6410.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5p6440.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5p6450.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5pc100.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5pv210.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/system-reset.h
