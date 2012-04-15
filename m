From: olof@lixom.net (Olof Johansson)
Date: Sun, 15 Apr 2012 10:56:40 -0700
Subject: [GIT PULL] ARM: fixes for 3.4-rc
Message-ID: <CAOesGMgk1vAByHXSZ+S7Ucnxo5-CK_Hibg5XUUN6zwrRHJkMpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/fixes-for-linus

for you to fetch changes up to 961a238c38a2716511dbd8e0f34d49dd46160007:

  Merge branch 'v3.4-samsung-fixes-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into
fixes (2012-04-14 17:50:45 -0700)

----------------------------------------------------------------

ARM: a few more SoC fixes for 3.4-rc

* A handful of warning and build fixes for Qualcomm MSM
* Build/warning and bug fixes for Samsung Exynos
* A fix from Rob Herring that removes misplaced interrupt-parent
  properties from a few device trees
* A fix to OMAP dealing with cpufreq build errors, removing some of the
  offending code since it was redundant anyway

----------------------------------------------------------------
Daniel Walker (2):
      arm: msm: halibut: remove unneeded fixup
      arm: msm: trout: fix compile failure

David Brown (2):
      video: msm: Fix section mismatches in mddi.c
      ARM: msm: Fix section mismatches in proc_comm.c

Jonghwan Choi (1):
      ARM: EXYNOS: Fix compile error in exynos5250-cpufreq.c

Kevin Hilman (1):
      ARM: OMAP: clock: cleanup CPUfreq leftovers, fix build errors

Kukjin Kim (1):
      ARM: S5PV210: fix unused LDO supply field from wm8994_pdata

Marek Szyprowski (3):
      ARM: EXYNOS: fix regulator name for NURI board
      ARM: EXYNOS: set fix xusbxti clock for NURI and Universal210 boards
      ARM: EXYNOS: Remove broken config values for touchscren for NURI board

Maurus Cuelenaere (1):
      ARM: SAMSUNG: make SAMSUNG_PM_DEBUG select DEBUG_LL

Olof Johansson (2):
      Merge branch 'msm-fix' of
git://git.kernel.org/.../davidb/linux-msm into fixes
      Merge branch 'v3.4-samsung-fixes-2' of
git://git.kernel.org/.../kgene/linux-samsung into fixes

Rob Herring (1):
      ARM: dts: remove blank interrupt-parent properties

Sachin Kamat (2):
      ARM: S5PV210: Fix compiler warning in dma.c file
      ARM: EXYNOS: Fix Kconfig dependencies for device tree enabled
machine files

Thomas Abraham (1):
      ARM: EXYNOS: Add PDMA and MDMA physical base address defines

Tushar Behera (1):
      ARM: EXYNOS: Add missing definition for IRQ_I2S0

 arch/arm/boot/dts/at91sam9g20.dtsi             |    1 -
 arch/arm/boot/dts/at91sam9g45.dtsi             |    1 -
 arch/arm/boot/dts/at91sam9x5.dtsi              |    1 -
 arch/arm/boot/dts/db8500.dtsi                  |    1 -
 arch/arm/boot/dts/highbank.dts                 |    1 -
 arch/arm/mach-exynos/Kconfig                   |    2 +
 arch/arm/mach-exynos/include/mach/irqs.h       |    2 +
 arch/arm/mach-exynos/include/mach/map.h        |    4 ++
 arch/arm/mach-exynos/include/mach/regs-clock.h |    6 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    2 +-
 arch/arm/mach-exynos/mach-nuri.c               |   46 +-------------
 arch/arm/mach-exynos/mach-universal_c210.c     |    2 +
 arch/arm/mach-msm/board-halibut.c              |    3 -
 arch/arm/mach-msm/board-trout-panel.c          |    1 +
 arch/arm/mach-msm/board-trout.c                |    1 +
 arch/arm/mach-msm/proc_comm.c                  |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c   |   80 ------------------------
 arch/arm/mach-omap2/clock.c                    |    5 --
 arch/arm/mach-omap2/clock.h                    |    8 ---
 arch/arm/mach-s5pv210/dma.c                    |    2 -
 arch/arm/mach-s5pv210/mach-aquila.c            |    4 +-
 arch/arm/mach-s5pv210/mach-goni.c              |    4 +-
 arch/arm/plat-omap/clock.c                     |   26 --------
 arch/arm/plat-omap/include/plat/clock.h        |   10 ---
 arch/arm/plat-samsung/Kconfig                  |    1 +
 drivers/video/msm/mddi.c                       |    8 +--
 26 files changed, 31 insertions(+), 193 deletions(-)
