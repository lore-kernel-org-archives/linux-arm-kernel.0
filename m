From: josh.wu@atmel.com (Josh Wu)
Date: Wed,  6 Nov 2013 18:01:11 +0800
Subject: [PATCH v3 1/2] ARM: at91: sama5d3: add support for sama5d36 chip
In-Reply-To: <1383732072-24938-1-git-send-email-josh.wu@atmel.com>
References: <1383732072-24938-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1383732072-24938-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SAMA5D36 chip is the superset product of SAMA5D3x family.

For detail information please refer to:
  http://www.atmel.com/Microsite/sama5d3/default.aspx

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
v1, v2 --> v3:
  none.

 arch/arm/mach-at91/Kconfig            |    2 +-
 arch/arm/mach-at91/include/mach/cpu.h |    3 ++-
 arch/arm/mach-at91/sama5d3.c          |    7 +++----
 arch/arm/mach-at91/setup.c            |    4 ++++
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 699b71e..44eacdd 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -67,7 +67,7 @@ config SOC_SAMA5D3
 	select HAVE_AT91_DBGU1
 	help
 	  Select this if you are using one of Atmel's SAMA5D3 family SoC.
-	  This support covers SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35.
+	  This support covers SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35, SAMA5D36.
 endif
 
 if SOC_SAM_V4_V5
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index d3d7b99..86c71de 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -53,6 +53,7 @@
 #define ARCH_EXID_SAMA5D33	0x00414300
 #define ARCH_EXID_SAMA5D34	0x00414301
 #define ARCH_EXID_SAMA5D35	0x00584300
+#define ARCH_EXID_SAMA5D36	0x00004301
 
 #define ARCH_FAMILY_AT91X92	0x09200000
 #define ARCH_FAMILY_AT91SAM9	0x01900000
@@ -105,7 +106,7 @@ enum at91_soc_subtype {
 
 	/* SAMA5D3 */
 	AT91_SOC_SAMA5D31, AT91_SOC_SAMA5D33, AT91_SOC_SAMA5D34,
-	AT91_SOC_SAMA5D35,
+	AT91_SOC_SAMA5D35, AT91_SOC_SAMA5D36,
 
 	/* No subtype for this SoC */
 	AT91_SOC_SUBTYPE_NONE,
diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
index 4012797..f853c97 100644
--- a/arch/arm/mach-at91/sama5d3.c
+++ b/arch/arm/mach-at91/sama5d3.c
@@ -177,25 +177,24 @@ static struct clk udphs_clk = {
 	.pid		= SAMA5D3_ID_UDPHS,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
-/* gmac only for sama5d33, sama5d34, sama5d35 */
+/* gmac only for sama5d33, sama5d34, sama5d35, sama5d36 */
 static struct clk macb0_clk = {
 	.name		= "macb0_clk",
 	.pid		= SAMA5D3_ID_GMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
-/* emac only for sama5d31, sama5d35 */
+/* emac only for sama5d31, sama5d35, sama5d36 */
 static struct clk macb1_clk = {
 	.name		= "macb1_clk",
 	.pid		= SAMA5D3_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
-/* lcd only for sama5d31, sama5d33, sama5d34 */
+/* lcd only for sama5d31, sama5d33, sama5d34, sama5d36 */
 static struct clk lcdc_clk = {
 	.name		= "lcdc_clk",
 	.pid		= SAMA5D3_ID_LCDC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
-/* isi only for sama5d33, sama5d35 */
 static struct clk isi_clk = {
 	.name		= "isi_clk",
 	.pid		= SAMA5D3_ID_ISI,
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index b17fbcf..157b687 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -232,6 +232,9 @@ static void __init soc_detect(u32 dbgu_base)
 		case ARCH_EXID_SAMA5D35:
 			at91_soc_initdata.subtype = AT91_SOC_SAMA5D35;
 			break;
+		case ARCH_EXID_SAMA5D36:
+			at91_soc_initdata.subtype = AT91_SOC_SAMA5D36;
+			break;
 		}
 	}
 }
@@ -274,6 +277,7 @@ static const char *soc_subtype_name[] = {
 	[AT91_SOC_SAMA5D33]	= "sama5d33",
 	[AT91_SOC_SAMA5D34]	= "sama5d34",
 	[AT91_SOC_SAMA5D35]	= "sama5d35",
+	[AT91_SOC_SAMA5D36]	= "sama5d36",
 	[AT91_SOC_SUBTYPE_NONE]	= "None",
 	[AT91_SOC_SUBTYPE_UNKNOWN] = "Unknown",
 };
-- 
1.7.10
