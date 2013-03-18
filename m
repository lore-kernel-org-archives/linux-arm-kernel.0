From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:46:56 +0900
Subject: [PATCH 04/43] ARM: shmobile: Remove sh73a0_get_core_count()
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Reduce the number of lines of code in smp-sh73a0.c
by getting rid of the sh73a0_get_core_count() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-sh73a0.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index acb46a9..81c0f4b 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -52,13 +52,6 @@ void __init sh73a0_register_twd(void)
 }
 #endif
 
-static unsigned int __init sh73a0_get_core_count(void)
-{
-	void __iomem *scu_base = scu_base_addr();
-
-	return scu_get_core_count(scu_base);
-}
-
 static void __cpuinit sh73a0_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
@@ -90,7 +83,7 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 
 static void __init sh73a0_smp_init_cpus(void)
 {
-	unsigned int ncores = sh73a0_get_core_count();
+	unsigned int ncores = scu_get_core_count(scu_base_addr());
 
 	shmobile_smp_init_cpus(ncores);
 }
-- 
1.7.10.4
