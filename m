From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 00:45:25 +0900
Subject: [PATCH 05/06] ARM: shmobile: Remove r8a7779_get_core_count()
In-Reply-To: <20130212154438.13067.77359.sendpatchset@w520>
References: <20130212154438.13067.77359.sendpatchset@w520>
Message-ID: <20130212154525.13067.38412.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Reduce the number of lines of code in smp-r8a7779.c
by getting rid of the r8a7779_get_core_count() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7779.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2013-02-12 23:51:15.000000000 +0900
@@ -87,13 +87,6 @@ static void modify_scu_cpu_psr(unsigned
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
@@ -178,7 +171,7 @@ static void __init r8a7779_smp_prepare_c
 
 static void __init r8a7779_smp_init_cpus(void)
 {
-	unsigned int ncores = r8a7779_get_core_count();
+	unsigned int ncores = scu_get_core_count(scu_base_addr());
 
 	shmobile_smp_init_cpus(ncores);
 }
