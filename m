From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 00:45:16 +0900
Subject: [PATCH 04/06] ARM: shmobile: Remove sh73a0_get_core_count()
In-Reply-To: <20130212154438.13067.77359.sendpatchset@w520>
References: <20130212154438.13067.77359.sendpatchset@w520>
Message-ID: <20130212154516.13067.82532.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Reduce the number of lines of code in smp-sh73a0.c
by getting rid of the sh73a0_get_core_count() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-02-12 23:50:18.000000000 +0900
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
@@ -90,7 +83,7 @@ static void __init sh73a0_smp_prepare_cp
 
 static void __init sh73a0_smp_init_cpus(void)
 {
-	unsigned int ncores = sh73a0_get_core_count();
+	unsigned int ncores = scu_get_core_count(scu_base_addr());
 
 	shmobile_smp_init_cpus(ncores);
 }
