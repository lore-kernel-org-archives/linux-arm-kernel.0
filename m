From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 28 Jul 2014 10:23:56 +0530
Subject: [PATCH v2 1/2] ARM: DRA7: Add support for soc_is_dra74x() and
 soc_is_dra72x() variants
In-Reply-To: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com>
References: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1406523237-6905-2-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Use the corresponding compatibles to identify the devices.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
---
Changes since v1:
	-Removed an extra blank line as suggested by Suman.
 arch/arm/mach-omap2/soc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 01ca808..4376f59 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -245,6 +245,8 @@ IS_AM_SUBCLASS(437x, 0x437)
 #define soc_is_omap54xx()		0
 #define soc_is_omap543x()		0
 #define soc_is_dra7xx()			0
+#define soc_is_dra74x()			0
+#define soc_is_dra72x()			0
 
 #if defined(MULTI_OMAP2)
 # if defined(CONFIG_ARCH_OMAP2)
@@ -393,7 +395,11 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #if defined(CONFIG_SOC_DRA7XX)
 #undef soc_is_dra7xx
+#undef soc_is_dra74x
+#undef soc_is_dra72x
 #define soc_is_dra7xx()	(of_machine_is_compatible("ti,dra7"))
+#define soc_is_dra74x()	(of_machine_is_compatible("ti,dra74"))
+#define soc_is_dra72x()	(of_machine_is_compatible("ti,dra72"))
 #endif
 
 /* Various silicon revisions for omap2 */
-- 
1.9.1
