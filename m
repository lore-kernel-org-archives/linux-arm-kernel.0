From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Fri, 22 May 2015 23:28:51 -0500
Subject: [PATCH 1/3] ARM: socfpga: use CPU_METHOD_OF_DECLARE for
 socfpga_cyclone5
In-Reply-To: <1432355333-15515-1-git-send-email-dinguyen@opensource.altera.com>
References: <1432355333-15515-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1432355333-15515-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Convert cyclone5/arria5 to use CPU_METHOD_OF_DECLARE for smp operations.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/mach-socfpga/platsmp.c | 2 ++
 arch/arm/mach-socfpga/socfpga.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 7886eae..08250c8 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -90,3 +90,5 @@ struct smp_operations socfpga_smp_ops __initdata = {
 	.cpu_die		= socfpga_cpu_die,
 #endif
 };
+
+CPU_METHOD_OF_DECLARE(socfpga_smp, "altr,socfpga-smp", &socfpga_smp_ops);
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index b63dec6..a154920 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -78,7 +78,6 @@ static const char *altera_dt_match[] = {
 DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.smp		= smp_ops(socfpga_smp_ops),
 	.init_irq	= socfpga_init_irq,
 	.restart	= socfpga_cyclone5_restart,
 	.dt_compat	= altera_dt_match,
-- 
2.2.1
