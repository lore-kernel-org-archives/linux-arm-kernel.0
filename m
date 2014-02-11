From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Tue, 11 Feb 2014 11:15:28 +0900
Subject: [PATCH v1 0/1] Boot all secondary cores on Exynos SoC's
Message-ID: <1392084929-14116-1-git-send-email-t.dakhran@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to implementation of exynos_boot_secondary function
only one secondary core boots on Exynos SoC's.

Two new functions added to power up and power down secondary cores:

static int exynos_core_power_up(unsigned int cpu);
static int exynos_core_power_down(unsigned int cpu).

Tested on linux kernel v3.14-rc2.

Comments and additions would be appreciated.
Thank you.
	Tarek.

Tarek Dakhran (1):
  ARM: EXYNOS: enable boot all secondary cpus instead 2

 arch/arm/mach-exynos/hotplug.c  |   11 ++++--
 arch/arm/mach-exynos/platsmp.c  |   75 ++++++++++++++++++++++++++++-----------
 arch/arm/mach-exynos/regs-pmu.h |    5 +++
 3 files changed, 68 insertions(+), 23 deletions(-)

-- 
1.7.10.4
