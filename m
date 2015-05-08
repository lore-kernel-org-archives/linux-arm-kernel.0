From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri,  8 May 2015 07:55:25 +0200
Subject: [PATCH 0/2] Make Tegra cpuidle driver PSCI compatible
Message-ID: <cover.1431064527.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two small patches so that we can keep the Tegra cpuidle driver enabled
even in the presence of PSCI which takes over some duties (U-Boot is
about to gain such support for Tegra124).

Jan

Jan Kiszka (2):
  ARM: Availability of psci_smp_available depends on CONFIG_SMP
  ARM: tegra: Disable cpuidle driver if PSCI is present

 arch/arm/include/asm/psci.h | 6 +++++-
 arch/arm/mach-tegra/Kconfig | 1 +
 arch/arm/mach-tegra/tegra.c | 4 +++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.1.4
