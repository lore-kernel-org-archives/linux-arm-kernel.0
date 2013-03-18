From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:46:57 +0900
Subject: [PATCH 05/43] ARM: shmobile: Remove r8a7779_get_core_count()
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Reduce the number of lines of code in smp-r8a7779.c
by getting rid of the r8a7779_get_core_count() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 3a4acf2..f46b516 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -87,13 +87,6 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 	__raw_writel(tmp, scu_base + 8);
 }
 
-static unsigned int __init r8a7779_get_core_count(void)
-{
-	void __iomem *scu_base = scu_base_addr();
-
-	return scu_get_core_count(scu_base);
-}
-
 static int r8a7779_platform_cpu_kill(unsigned int cpu)
 {
 	struct r8a7779_pm_ch *ch = NULL;
@@ -178,7 +171,7 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 
 static void __init r8a7779_smp_init_cpus(void)
 {
-	unsigned int ncores = r8a7779_get_core_count();
+	unsigned int ncores = scu_get_core_count(scu_base_addr());
 
 	shmobile_smp_init_cpus(ncores);
 }
-- 
1.7.10.4
