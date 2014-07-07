From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Jul 2014 08:11:47 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.16
Message-ID: <53BB2933.3050309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4c834452aad01531db949414f94f817a86348d59:

   Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-2

for you to fetch changes up to 35e75645f16c86918f26df1bfc2c24ad8ebb5a17:

   ARM: EXYNOS: Update secondary boot addr for secure mode (2014-07-08 
08:03:49 +0900)

----------------------------------------------------------------
Samsung fixes-2 for v3.16
- fix the check for SMP configuration with using CONFIG_SMP
   not just SMP
- fix the number of pwm-cells for exynos4 pwm
- fix ftrace for exynos_mct
- register exynos_mct for stable udely
- fix secondary boot addr for secure mode for exynos SoCs

----------------------------------------------------------------
Abhilash Kesavan (1):
       ARM: EXYNOS: Fix the check for non-smp configuration

Amit Daniel Kachhap (1):
       clocksource: exynos_mct: Register the timer for stable udelay

Doug Anderson (1):
       clocksource: exynos_mct: Fix ftrace

Jaewon Kim (1):
       ARM: dts: fix pwm-cells in pwm node for exynos4

Sachin Kamat (1):
       ARM: EXYNOS: Update secondary boot addr for secure mode

  arch/arm/boot/dts/exynos4.dtsi   |  2 +-
  arch/arm/mach-exynos/exynos.c    |  2 +-
  arch/arm/mach-exynos/firmware.c  |  9 +++++++--
  drivers/clocksource/exynos_mct.c | 20 ++++++++++++++++++--
  4 files changed, 27 insertions(+), 6 deletions(-)
