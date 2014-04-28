From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:34:02 +0100
Subject: [PATCH 92/97] ARM: l2c: convert vexpress to generic l2c initialisation
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerJS-0001Zw-2n@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/v2m.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 4f8b8cb17ff5..b2fea70d412d 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -432,7 +432,6 @@ static const struct of_device_id v2m_dt_bus_match[] __initconst = {
 
 static void __init v2m_dt_init(void)
 {
-	l2x0_of_init(0x00400000, 0xfe0fffff);
 	of_platform_populate(NULL, v2m_dt_bus_match, NULL, NULL);
 }
 
@@ -443,6 +442,8 @@ static const char * const v2m_dt_match[] __initconst = {
 
 DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.dt_compat	= v2m_dt_match,
+	.l2c_aux_val	= 0x00400000,
+	.l2c_aux_mask	= 0xfe0fffff,
 	.smp		= smp_ops(vexpress_smp_ops),
 	.smp_init	= smp_init_ops(vexpress_smp_init_ops),
 	.map_io		= v2m_dt_map_io,
-- 
1.8.3.1
