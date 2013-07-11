From: afzal@ti.com (Afzal Mohammed)
Date: Thu, 11 Jul 2013 12:07:01 +0530
Subject: [PATCH RFC 12/13] ARM: OMAP2+: hwmod: type4 sysc
In-Reply-To: <cover.1373519192.git.afzal@ti.com>
References: <cover.1373519192.git.afzal@ti.com>
Message-ID: <1b8dd5893a03a42648a417837fafb193fd69a141.1373519192.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM43x PKA module has sysconfig bitmap different from that of the
existing available types, hence add a new one.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h             | 5 +++++
 arch/arm/mach-omap2/omap_hwmod_common_data.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 29f7687..a743358 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -41,6 +41,7 @@ struct omap_device;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
+extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type4;
 
 /*
  * OCP SYSCONFIG bit shifts/masks TYPE1. These are for IPs compliant
@@ -81,6 +82,10 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
 #define SYSC_TYPE3_MIDLEMODE_SHIFT	2
 #define SYSC_TYPE3_MIDLEMODE_MASK	(0x3 << SYSC_TYPE3_MIDLEMODE_SHIFT)
 
+#define SYSC_TYPE4_SIDLEMODE_SHIFT	4
+#define SYSC_TYPE4_SOFTRESET_SHIFT	1
+#define SYSC_TYPE4_AUTOIDLE_SHIFT	0
+
 /* OCP SYSSTATUS bit shifts/masks */
 #define SYSS_RESETDONE_SHIFT		0
 #define SYSS_RESETDONE_MASK		(1 << SYSS_RESETDONE_SHIFT)
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
index 79d623b..238c2c1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -59,6 +59,12 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3 = {
 	.sidle_shift	= SYSC_TYPE3_SIDLEMODE_SHIFT,
 };
 
+struct omap_hwmod_sysc_fields omap_hwmod_sysc_type4 = {
+	.sidle_shift	= SYSC_TYPE4_SIDLEMODE_SHIFT,
+	.srst_shift	= SYSC_TYPE4_SOFTRESET_SHIFT,
+	.autoidle_shift	= SYSC_TYPE4_AUTOIDLE_SHIFT,
+};
+
 struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr = {
 	.manager_count		= 2,
 	.has_framedonetv_irq	= 0
-- 
1.8.3.1
