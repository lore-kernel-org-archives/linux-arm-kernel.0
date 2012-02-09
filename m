From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 10 Feb 2012 01:47:43 +0200
Subject: [PATCH v3 03/10] ARM: tegra: initialize Tegra chipid early
In-Reply-To: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1328831277-21002-4-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Secondary core bringup relies on the Tegra chipid to distinguish between
Tegra variants. Therefore this data needs to be available early on.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index e2a2c1f..bdc5d5e 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -125,6 +125,7 @@ void __init tegra20_init_early(void)
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 void __init tegra30_init_early(void)
 {
+	tegra_init_fuse();
 	tegra30_init_clocks();
 	tegra_init_cache(0x441, 0x551);
 	tegra_pmc_init();
-- 
1.7.4.1
