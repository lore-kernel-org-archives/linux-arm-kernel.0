From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Fri, 8 Aug 2014 02:01:52 +0300
Subject: [PATCH 0/3] Introduce of_match_machine() helper
Message-ID: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some mach-specific drivers that don't require their own node in the device tree
(for example drivers/soc/*, cpufreq, cpuidle etc.) want to match on the device
tree root compatible property instead. Instead of open-coding (and forgetting
to call of_node_put on the root node) everywhere, add a helper to the OF core.

Tuomas Tynkkynen (3):
  of: Add of_match_machine helper
  soc/tegra: Use of_match_machine in soc_is_tegra()
  cpuidle: big.LITTLE: Use of_match_machine

 drivers/cpuidle/cpuidle-big_little.c |  6 +-----
 drivers/of/base.c                    | 21 +++++++++++++++++++++
 drivers/soc/tegra/common.c           |  8 +-------
 include/linux/of.h                   |  3 +++
 4 files changed, 26 insertions(+), 12 deletions(-)

-- 
1.8.1.5
