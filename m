From: bilhuang@nvidia.com (Bill Huang)
Date: Thu, 12 Sep 2013 04:24:47 -0700
Subject: [PATCH v2 0/4] Remodel Tegra cpufreq driver to support Tegra series
 SoCs
Message-ID: <1378985091-9447-1-git-send-email-bilhuang@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series remodel Tegra cpufreq driver to make it more easy to
add new SoC support, in addition to that, adding probe function in the
driver to let probe defer can be used to control init sequence when we
going to support DVFS.

Changes since v1:

- Split up patches.
- Split configuration-time data out of structure "tegra_cpufreq_data".
- Bug fixes.

Bill Huang (4):
  cpufreq: tegra: Call tegra_cpufreq_init() specifically in machine
    code
  cpufreq: tegra: Remove not used header files and clean up codes
  cpufreq: tegra: Re-model Tegra cpufreq driver
  ARM: tegra: defconfig updates

 arch/arm/configs/tegra_defconfig  |    1 +
 arch/arm/mach-tegra/common.c      |    2 +
 drivers/cpufreq/Kconfig.arm       |    8 +-
 drivers/cpufreq/Makefile          |    1 +
 drivers/cpufreq/tegra-cpufreq.c   |  194 +++++++++++++++++--------------------
 drivers/cpufreq/tegra-cpufreq.h   |   42 ++++++++
 drivers/cpufreq/tegra20-cpufreq.c |  138 ++++++++++++++++++++++++++
 include/linux/tegra-soc.h         |   11 ++-
 8 files changed, 290 insertions(+), 107 deletions(-)
 create mode 100644 drivers/cpufreq/tegra-cpufreq.h
 create mode 100644 drivers/cpufreq/tegra20-cpufreq.c

-- 
1.7.9.5
