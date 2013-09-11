From: bilhuang@nvidia.com (Bill Huang)
Date: Wed, 11 Sep 2013 04:19:12 -0700
Subject: [PATCH 0/2] Remodel Tegra cpufreq driver to support Tegra series SoCs
Message-ID: <1378898355-31290-1-git-send-email-bilhuang@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series remodel Tegra cpufreq driver to make it more easy to
add new SoC support, in addition to that, adding probe function in the
driver to let probe defer can be used to control init sequence when we
going to support DVFS.

Bill Huang (2):
  cpufreq: tegra: Remove not used header and clean up codes
  cpufreq: tegra: Re-model Tegra cpufreq driver

 arch/arm/mach-tegra/common.c      |    2 +
 drivers/cpufreq/Kconfig.arm       |   16 +++-
 drivers/cpufreq/Makefile          |    1 +
 drivers/cpufreq/tegra-cpufreq.c   |  192 +++++++++++++++++--------------------
 drivers/cpufreq/tegra-cpufreq.h   |   37 +++++++
 drivers/cpufreq/tegra20-cpufreq.c |  133 +++++++++++++++++++++++++
 include/linux/tegra-soc.h         |   11 ++-
 7 files changed, 283 insertions(+), 109 deletions(-)
 create mode 100644 drivers/cpufreq/tegra-cpufreq.h
 create mode 100644 drivers/cpufreq/tegra20-cpufreq.c

-- 
1.7.9.5
