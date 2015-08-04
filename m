From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 04 Aug 2015 16:28:47 +0900
Subject: [GIT PULL 2/5] Samsung cleanup for v4.3
Message-ID: <55C069AF.5050300@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull Samsung cleanup for v4.3.
Note I'm going to cleanup non-used definitions based on this soon.

Thanks,
Kukjin


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-cleanup

for you to fetch changes up to d306d08f07183fe1504257101b25b5b33d77bae9:

  ARM: SAMSUNG: remove keypad-core header in plat-samsung (2015-07-30
02:02:06 +0900)

----------------------------------------------------------------
Samsung cleanup for v4.3

- make the following headers local
  watchdog-reset, onenand-core, irq-uart, backlight,
  ata-core, regs-usb-hsotg-phy, spi-core, nand-core,
  fb-core and regs-srom headers
- make the following c file local
  s5p-dev-mfc, dev-backlight and setup-camif c file
- remove keypad-core.h file
- drop owner assignment in pmu.c
- remove duplicated define of SLEEP_MAGIC
- make exynos5420_powerdown_conf() staic

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: EXYNOS: Make local function static
      ARM: EXYNOS: Remove duplicated define of SLEEP_MAGIC
      ARM: EXYNOS: Drop owner assignment in pmu.c

Kukjin Kim (14):
      ARM: SAMSUNG: make local setup-camif in mach-s3c24xx
      ARM: SAMSUNG: make local dev-backlight in mach-s3c64xx
      ARM: SAMSUNG: make local s5p-dev-mfc in mach-exynos
      ARM: SAMSUNG: local regs-srom header in mach-exynos
      ARM: SAMSUNG: local fb-core header in mach-s3c24xx
      ARM: SAMSUNG: local nand-core header in mach-s3c24xx
      ARM: SAMSUNG: local spi-core header in mach-s3c24xx
      ARM: SAMSUNG: local regs-usb-hsotg-phy header in mach-s3c64xx
      ARM: SAMSUNG: local ata-core header in mach-s3c64xx
      ARM: SAMSUNG: local backlight header in mach-s3c64xx
      ARM: SAMSUNG: local irq-uart header in mach-s3c64xx
      ARM: SAMSUNG: local onenand-core header in mach-s3c64xx
      ARM: SAMSUNG: local watchdog-reset header in mach-s3c64xx
      ARM: SAMSUNG: remove keypad-core header in plat-samsung

 arch/arm/mach-exynos/Kconfig                       |  5 ++++
 arch/arm/mach-exynos/Makefile                      |  2 ++
 arch/arm/mach-exynos/common.h                      |  6 +++++
 arch/arm/mach-exynos/firmware.c                    |  2 --
 arch/arm/mach-exynos/pmu.c                         |  3 +--
 .../include/plat => mach-exynos}/regs-srom.h       |  3 +--
 .../{plat-samsung => mach-exynos}/s5p-dev-mfc.c    |  0
 arch/arm/mach-exynos/suspend.c                     |  8 +++---
 arch/arm/mach-s3c24xx/Kconfig                      |  5 ++++
 arch/arm/mach-s3c24xx/Makefile                     |  1 +
 .../include/plat => mach-s3c24xx}/fb-core.h        |  2 --
 .../include/plat => mach-s3c24xx}/nand-core.h      |  3 +--
 arch/arm/mach-s3c24xx/s3c2412.c                    |  2 +-
 arch/arm/mach-s3c24xx/s3c2416.c                    |  6 ++---
 arch/arm/mach-s3c24xx/s3c2443.c                    |  7 ++---
 arch/arm/mach-s3c24xx/s3c244x.c                    |  2 +-
 .../{plat-samsung => mach-s3c24xx}/setup-camif.c   |  0
 .../include/plat => mach-s3c24xx}/spi-core.h       |  0
 arch/arm/mach-s3c64xx/Kconfig                      |  6 +++++
 arch/arm/mach-s3c64xx/Makefile                     |  2 ++
 .../include/plat => mach-s3c64xx}/ata-core.h       |  3 +--
 .../include/plat => mach-s3c64xx}/backlight.h      |  3 +--
 arch/arm/mach-s3c64xx/common.c                     |  4 +--
 .../{plat-samsung => mach-s3c64xx}/dev-backlight.c |  6 ++---
 .../include/plat => mach-s3c64xx}/irq-uart.h       |  3 +--
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c            |  3 +--
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |  2 +-
 .../include/plat => mach-s3c64xx}/onenand-core.h   |  2 --
 .../plat => mach-s3c64xx}/regs-usb-hsotg-phy.h     |  3 +--
 arch/arm/mach-s3c64xx/s3c6400.c                    |  2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |  4 +--
 arch/arm/mach-s3c64xx/setup-usb-phy.c              |  2 +-
 .../include/plat => mach-s3c64xx}/watchdog-reset.h |  3 +--
 arch/arm/plat-samsung/Kconfig                      | 17 ------------
 arch/arm/plat-samsung/Makefile                     |  5 ----
 arch/arm/plat-samsung/include/plat/keypad-core.h   | 31
----------------------
 36 files changed, 58 insertions(+), 100 deletions(-)
 rename arch/arm/{plat-samsung/include/plat => mach-exynos}/regs-srom.h
(96%)
 rename arch/arm/{plat-samsung => mach-exynos}/s5p-dev-mfc.c (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c24xx}/fb-core.h (93%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c24xx}/nand-core.h
(93%)
 rename arch/arm/{plat-samsung => mach-s3c24xx}/setup-camif.c (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c24xx}/spi-core.h
(100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/ata-core.h
(92%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/backlight.h
(92%)
 rename arch/arm/{plat-samsung => mach-s3c64xx}/dev-backlight.c (98%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/irq-uart.h
(90%)
 rename arch/arm/{plat-samsung/include/plat =>
mach-s3c64xx}/onenand-core.h (95%)
 rename arch/arm/{plat-samsung/include/plat =>
mach-s3c64xx}/regs-usb-hsotg-phy.h (96%)
 rename arch/arm/{plat-samsung/include/plat =>
mach-s3c64xx}/watchdog-reset.h (91%)
 delete mode 100644 arch/arm/plat-samsung/include/plat/keypad-core.h
