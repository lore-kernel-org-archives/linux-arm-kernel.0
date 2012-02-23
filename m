From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 23 Feb 2012 18:20:56 +0200
Subject: [PATCH] ARM: tegra: Enable CPUIdle on Tegra20
Message-ID: <1330014056-26125-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the LP3 code also works for Tegra20, we can enable cpuidle for Tegra20.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

---
Tested on Tegra2 Ventana,
/sys/devices/system/cpu/cpu[0-1]/cpuidle/state0/usage increments over time
and the system is stable.

---
 arch/arm/mach-tegra/common.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index e2a2c1f..2f86fcc 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -113,8 +113,6 @@ static void __init tegra_init_cache(u32 tag_latency, u32 data_latency)
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void __init tegra20_init_early(void)
 {
-	disable_hlt();  /* idle WFI usage needs to be confirmed */
-
 	tegra_init_fuse();
 	tegra2_init_clocks();
 	tegra_clk_init_from_table(tegra20_clk_init_table);
-- 
1.7.7.rc0.72.g4b5ea.dirty
