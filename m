From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 23 Jul 2013 12:32:40 +0100
Subject: [PATCH 1/5] ARM: keystone: remove redundant smp_init_cpus definition
In-Reply-To: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1374579164-30255-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

arm_dt_init_cpu_maps is called before smp_init_cpus. It makes the
platform/SoC definition of smp_init_cpus unnecessary.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-keystone/platsmp.c | 1 -
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
1.8.1.2
