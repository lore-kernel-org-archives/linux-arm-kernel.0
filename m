From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  5 Jun 2015 12:47:57 +0800
Subject: [PATCH 3/3] ARM: rockchip: fix the SMP code style
In-Reply-To: <1433479677-18086-1-git-send-email-wxt@rock-chips.com>
References: <1433479677-18086-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1433479677-18086-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the below scripts to check:
scripts/checkpatch.pl -f arch/arm/mach-rockchip/platsmp.c

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/mach-rockchip/platsmp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 978c357..7eea805 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -104,7 +104,7 @@ static int pmu_set_power_domain(int pd, bool on)
 		ret = pmu_power_domain_is_on(pd);
 		if (ret < 0) {
 			pr_err("%s: could not read power domain state\n",
-				 __func__);
+			       __func__);
 			return ret;
 		}
 	}
@@ -128,7 +128,7 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 
 	if (cpu >= ncores) {
 		pr_err("%s: cpu %d outside maximum number of cpus %d\n",
-							__func__, cpu, ncores);
+		       __func__, cpu, ncores);
 		return -ENXIO;
 	}
 
@@ -147,7 +147,7 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 		 * */
 		udelay(10);
 		writel(virt_to_phys(rockchip_secondary_startup),
-			sram_base_addr + 8);
+		       sram_base_addr + 8);
 		writel(0xDEADBEAF, sram_base_addr + 4);
 		dsb_sev();
 	}
@@ -326,7 +326,7 @@ static int rockchip_cpu_kill(unsigned int cpu)
 static void rockchip_cpu_die(unsigned int cpu)
 {
 	v7_exit_coherency_flush(louis);
-	while(1)
+	while (1)
 		cpu_do_idle();
 }
 #endif
-- 
1.9.1
