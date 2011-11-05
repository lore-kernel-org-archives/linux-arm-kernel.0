From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 05 Nov 2011 09:01:20 +0900
Subject: [GIT PULL] Samsung Exynos for v3.2
Message-ID: <02dd01cc9b4e$0cb27c80$26177580$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

As you suggested, I made reorganization mach-exynos branch,
next-samsung-exynos in my tree and it has been tested on some boards.

Please pull from: 
  git://github.com/kgene/linux-samsung.git next-samsung-exynos

As a note, will finish other separate branch today.

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

  git://github.com/kgene/linux-samsung.git next-samsung-exynos

Jonghwan Choi (1):
      ARM: SAMSUNG: Fix compile error due to kfree

Joonyoung Shim (1):
      ARM: SAMSUNG: Add clk enable/disable of pwm

Kukjin Kim (1):
      ARM: EXYNOS: Add ARCH_EXYNOS and reorganize arch/arm/mach-exynos

Marc Zyngier (1):
      ARM: EXYNOS4: convert MCT to percpu interrupt API

 arch/arm/Kconfig                                   |    8 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/configs/exynos4_defconfig                 |    9 +--
 arch/arm/{mach-exynos4 => mach-exynos}/Kconfig     |   41 +++++++++---
 arch/arm/{mach-exynos4 => mach-exynos}/Makefile    |   11 ++--
 .../{mach-exynos4 => mach-exynos}/Makefile.boot    |    0
 .../clock-exynos4210.c                             |    0
 .../clock-exynos4212.c                             |    0
 arch/arm/{mach-exynos4 => mach-exynos}/clock.c     |    0
 arch/arm/{mach-exynos4 => mach-exynos}/cpu.c       |   69
+++++++++++---------
 arch/arm/{mach-exynos4 => mach-exynos}/cpuidle.c   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-ahci.c  |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-audio.c |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-dwmci.c |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dev-pd.c    |    0
 .../arm/{mach-exynos4 => mach-exynos}/dev-sysmmu.c |    0
 arch/arm/{mach-exynos4 => mach-exynos}/dma.c       |    0
 arch/arm/{mach-exynos4 => mach-exynos}/headsmp.S   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/hotplug.c   |    0
 .../include/mach/debug-macro.S                     |    0
 .../include/mach/dma.h                             |    0
 .../include/mach/dwmci.h                           |    0
 .../include/mach/entry-macro.S                     |    0
 .../include/mach/exynos4-clock.h                   |    0
 .../include/mach/gpio.h                            |    0
 .../include/mach/hardware.h                        |    0
 .../include/mach/io.h                              |    0
 .../include/mach/irqs.h                            |    0
 .../include/mach/map.h                             |   32 ++++++----
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
 arch/arm/{mach-exynos4 => mach-exynos}/init.c      |    0
 .../{mach-exynos4 => mach-exynos}/irq-combiner.c   |    0
 arch/arm/{mach-exynos4 => mach-exynos}/irq-eint.c  |    0
.../mach-armlex4210.c                              |    0
 arch/arm/{mach-exynos4 => mach-exynos}/mach-nuri.c |    0
 .../{mach-exynos4 => mach-exynos}/mach-origen.c    |    0
 .../{mach-exynos4 => mach-exynos}/mach-smdk4x12.c  |    0
 .../{mach-exynos4 => mach-exynos}/mach-smdkv310.c  |    0
 .../mach-universal_c210.c                          |    0
 arch/arm/{mach-exynos4 => mach-exynos}/mct.c       |   40 ++++++++----
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
 .../{mach-exynos4 => mach-exynos}/setup-sdhci.c    |    0
 .../{mach-exynos4 => mach-exynos}/setup-usb-phy.c  |    0
 arch/arm/plat-s5p/Kconfig                          |    2 +-
 arch/arm/plat-s5p/cpu.c                            |    6 +-
 arch/arm/plat-samsung/dev-backlight.c              |    1 +
 arch/arm/plat-samsung/include/plat/exynos4.h       |    6 +-
 arch/arm/plat-samsung/pwm.c                        |    7 ++
 78 files changed, 141 insertions(+), 93 deletions(-)
 rename arch/arm/{mach-exynos4 => mach-exynos}/Kconfig (92%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/Makefile (90%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/Makefile.boot (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock-exynos4210.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock-exynos4212.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/clock.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/cpu.c (91%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/cpuidle.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-ahci.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-audio.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-dwmci.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-pd.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dev-sysmmu.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/dma.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/headsmp.S (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/hotplug.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/debug-macro.S
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/dma.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/dwmci.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/entry-macro.S
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/exynos4-clock.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/gpio.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/hardware.h
(100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/io.h (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/include/mach/irqs.h (100%)
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
 rename arch/arm/{mach-exynos4 => mach-exynos}/init.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/irq-combiner.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/irq-eint.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-armlex4210.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-nuri.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/mach-origen.c (100%)
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
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-sdhci.c (100%)
 rename arch/arm/{mach-exynos4 => mach-exynos}/setup-usb-phy.c (100%)
