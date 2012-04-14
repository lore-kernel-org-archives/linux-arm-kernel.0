From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 14 Apr 2012 09:07:01 -0700
Subject: [GIT PULL] Samsung fixes-2 for v3.4
Message-ID: <4F89A0A5.5030806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull samsung fixes-2 for v3.4 from following:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.4-samsung-fixes-2

Most are for fix of build failure :( and warnings.
If any problems, please let me know.

Note that according to changing the device name for sdhci controllers 
and removing clk_type from sdhci platform_data after v3.4-rc1, need to 
update regarding stuff in samsung arch part so I'm preparing its fix in 
samsung-fixes-3. I will send it next turn.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

   Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.4-samsung-fixes-2

Jonghwan Choi (1):
       ARM: EXYNOS: Fix compile error in exynos5250-cpufreq.c

Kukjin Kim (1):
       ARM: S5PV210: fix unused LDO supply field from wm8994_pdata

Marek Szyprowski (3):
       ARM: EXYNOS: fix regulator name for NURI board
       ARM: EXYNOS: set fix xusbxti clock for NURI and Universal210 boards
       ARM: EXYNOS: Remove broken config values for touchscren for NURI 
board

Maurus Cuelenaere (1):
       ARM: SAMSUNG: make SAMSUNG_PM_DEBUG select DEBUG_LL

Sachin Kamat (2):
       ARM: S5PV210: Fix compiler warning in dma.c file
       ARM: EXYNOS: Fix Kconfig dependencies for device tree enabled 
machine files

Thomas Abraham (1):
       ARM: EXYNOS: Add PDMA and MDMA physical base address defines

Tushar Behera (1):
       ARM: EXYNOS: Add missing definition for IRQ_I2S0

  arch/arm/mach-exynos/Kconfig                   |    2 +
  arch/arm/mach-exynos/include/mach/irqs.h       |    2 +
  arch/arm/mach-exynos/include/mach/map.h        |    4 ++
  arch/arm/mach-exynos/include/mach/regs-clock.h |    6 +++
  arch/arm/mach-exynos/mach-exynos5-dt.c         |    2 +-
  arch/arm/mach-exynos/mach-nuri.c               |   46 
+----------------------
  arch/arm/mach-exynos/mach-universal_c210.c     |    2 +
  arch/arm/mach-s5pv210/dma.c                    |    2 -
  arch/arm/mach-s5pv210/mach-aquila.c            |    4 +-
  arch/arm/mach-s5pv210/mach-goni.c              |    4 +-
  arch/arm/plat-samsung/Kconfig                  |    1 +
  11 files changed, 24 insertions(+), 51 deletions(-)
