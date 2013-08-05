From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 14:11:09 -0400
Subject: [RESEND PATCH 2/7] ARM: keystone: remove redundant smp_init_cpus
 definition
In-Reply-To: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375726274-26000-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>

arm_dt_init_cpu_maps is called before smp_init_cpus. It makes the
platform/SoC definition of smp_init_cpus unnecessary.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/platsmp.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 14378e3..c122961 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -38,6 +38,5 @@ static int keystone_smp_boot_secondary(unsigned int cpu,
 }
 
 struct smp_operations keystone_smp_ops __initdata = {
-	.smp_init_cpus		= arm_dt_init_cpu_maps,
 	.smp_boot_secondary	= keystone_smp_boot_secondary,
 };
-- 
1.7.9.5
