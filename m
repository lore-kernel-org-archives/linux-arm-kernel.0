From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 21:08:14 -0500
Subject: [PATCH 07/10] ARM: vexpress: use common scu_init_cpus
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <1304129297-6614-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert Versatile Express to use common scu_init_cpus function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index a96772d..4d1476f 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -206,10 +206,7 @@ static void __init ct_ca9x4_init(void)
 #ifdef CONFIG_SMP
 static void ct_ca9x4_init_cpu_map(void)
 {
-	int i, ncores = scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
-
-	for (i = 0; i < ncores; ++i)
-		set_cpu_possible(i, true);
+	scu_init_cpus(MMIO_P2V(A9_MPCORE_SCU));
 }
 
 static void ct_ca9x4_smp_enable(unsigned int max_cpus)
-- 
1.7.1
