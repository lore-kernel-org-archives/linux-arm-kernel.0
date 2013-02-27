From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 27 Feb 2013 10:28:03 +0800
Subject: [PATCH V2 0/4] ARM: tegra114: bring up secondary CPU for SMP
Message-ID: <1361932087-13372-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series bring up secondary CPU for Tegra114. Because we are going to
support generic power domain later, the conventional powergate driver will
be removed. So we add the CPU power on/off function in PMC driver first.

This series was dependent on the patches below.
"ARM: tegra: don't unlock MMIO access to DBGLAR for working"
"ARM: tegra: Fix unchecked return value"
"ARM: tegra30: fix the logical detection of power on sequence of warm boot CPUs"
"ARM: tegra: refactor tegra{20,30}_boot_secondary"

And the V2 series below.
"ARM: tegra: pmc: add specific compatible DT string for Tegra30 and Tegra114"
"ARM: dts: tegra: fix the PMC compatible string"

V2:
* take care the comments from V1

Joseph Lo (4):
  ARM: tegra: pmc: convert PMC driver to support DT only
  ARM: tegra: pmc: add power on function for secondary CPUs
  ARM: tegra30: platsmp: replace the CPU power on function in PMC driver
  ARM: tegra114: bring up secondary CPU for SMP

 arch/arm/mach-tegra/platsmp.c |  27 +++----
 arch/arm/mach-tegra/pmc.c     | 159 ++++++++++++++++++++++++++++++++++--------
 arch/arm/mach-tegra/pmc.h     |   4 ++
 3 files changed, 148 insertions(+), 42 deletions(-)

-- 
1.8.1.1
