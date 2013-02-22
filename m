From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 22 Feb 2013 14:44:47 +0800
Subject: [PATCH 0/4] ARM: tegra114: bring up secondary CPU for SMP
Message-ID: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series bring up secondary CPU for Tegra114. Because we are going to
support generic power domain later, the conventional powergate driver will
be removed. So we add the CPU power on/off function in PMC driver first.

This series was dependent on the patches below.
"ARM: tegra: Fix unchecked return value"
"ARM: tegra30: fix the logical detection of power on sequence of warm boot CPUs"
"ARM: tegra: refactor tegra{20,30}_boot_secondary"

Joseph Lo (4):
  ARM: tegra: pmc: convert PMC driver to support DT only
  ARM: tegra: pmc: add power on function for secondary CPUs
  ARM: tegra30: platsmp: replace the CPU power on function in PMC driver
  ARM: tegra114: bring up secondary CPU for SMP

 arch/arm/mach-tegra/platsmp.c |  27 +++----
 arch/arm/mach-tegra/pmc.c     | 159 ++++++++++++++++++++++++++++++++++--------
 arch/arm/mach-tegra/pmc.h     |   4 ++
 3 files changed, 149 insertions(+), 41 deletions(-)

-- 
1.8.1.1
