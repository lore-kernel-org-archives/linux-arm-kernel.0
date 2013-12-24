From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:15:46 +0900
Subject: [PATCH 02/29] ARM: shmobile: sh7372: Use macros to declare SCIF
 devices
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <c6a0d864b83178ab47822fdbfbe699c34a8b4b44.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace copy-n-paste SCIF platform data and device declaration with a
macro. This reduces the amount of code and improves readability.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 156 ++++++----------------------------
 1 file changed, 25 insertions(+), 131 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 3118783..77627dd 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -86,138 +86,32 @@ void __init sh7372_pinmux_init(void)
 	platform_device_register(&sh7372_pfc_device);
 }
 
-/* SCIFA0 */
-static struct plat_sci_port scif0_platform_data = {
-	.mapbase	= 0xe6c40000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { evt2irq(0x0c00), evt2irq(0x0c00),
-			    evt2irq(0x0c00), evt2irq(0x0c00) },
-};
-
-static struct platform_device scif0_device = {
-	.name		= "sh-sci",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &scif0_platform_data,
-	},
-};
-
-/* SCIFA1 */
-static struct plat_sci_port scif1_platform_data = {
-	.mapbase	= 0xe6c50000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { evt2irq(0x0c20), evt2irq(0x0c20),
-			    evt2irq(0x0c20), evt2irq(0x0c20) },
-};
-
-static struct platform_device scif1_device = {
-	.name		= "sh-sci",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &scif1_platform_data,
-	},
-};
-
-/* SCIFA2 */
-static struct plat_sci_port scif2_platform_data = {
-	.mapbase	= 0xe6c60000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { evt2irq(0x0c40), evt2irq(0x0c40),
-			    evt2irq(0x0c40), evt2irq(0x0c40) },
-};
-
-static struct platform_device scif2_device = {
-	.name		= "sh-sci",
-	.id		= 2,
-	.dev		= {
-		.platform_data	= &scif2_platform_data,
-	},
-};
-
-/* SCIFA3 */
-static struct plat_sci_port scif3_platform_data = {
-	.mapbase	= 0xe6c70000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { evt2irq(0x0c60), evt2irq(0x0c60),
-			    evt2irq(0x0c60), evt2irq(0x0c60) },
-};
-
-static struct platform_device scif3_device = {
-	.name		= "sh-sci",
-	.id		= 3,
-	.dev		= {
-		.platform_data	= &scif3_platform_data,
-	},
-};
-
-/* SCIFA4 */
-static struct plat_sci_port scif4_platform_data = {
-	.mapbase	= 0xe6c80000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { evt2irq(0x0d20), evt2irq(0x0d20),
-			    evt2irq(0x0d20), evt2irq(0x0d20) },
-};
-
-static struct platform_device scif4_device = {
-	.name		= "sh-sci",
-	.id		= 4,
-	.dev		= {
-		.platform_data	= &scif4_platform_data,
-	},
-};
-
-/* SCIFA5 */
-static struct plat_sci_port scif5_platform_data = {
-	.mapbase	= 0xe6cb0000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFA,
-	.irqs		= { evt2irq(0x0d40), evt2irq(0x0d40),
-			    evt2irq(0x0d40), evt2irq(0x0d40) },
-};
-
-static struct platform_device scif5_device = {
-	.name		= "sh-sci",
-	.id		= 5,
-	.dev		= {
-		.platform_data	= &scif5_platform_data,
-	},
-};
-
-/* SCIFB */
-static struct plat_sci_port scif6_platform_data = {
-	.mapbase	= 0xe6c30000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIFB,
-	.irqs		= { evt2irq(0x0d60), evt2irq(0x0d60),
-			    evt2irq(0x0d60), evt2irq(0x0d60) },
-};
+/* SCIF */
+#define SH7372_SCIF(scif_type, index, baseaddr, irq)		\
+static struct plat_sci_port scif##index##_platform_data = {	\
+	.type		= scif_type,				\
+	.mapbase	= baseaddr,				\
+	.flags		= UPF_BOOT_AUTOCONF,			\
+	.irqs		= SCIx_IRQ_MUXED(irq),			\
+	.scbrr_algo_id	= SCBRR_ALGO_4,				\
+	.scscr		= SCSCR_RE | SCSCR_TE,			\
+};								\
+								\
+static struct platform_device scif##index##_device = {		\
+	.name		= "sh-sci",				\
+	.id		= index,				\
+	.dev		= {					\
+		.platform_data	= &scif##index##_platform_data,	\
+	},							\
+}
 
-static struct platform_device scif6_device = {
-	.name		= "sh-sci",
-	.id		= 6,
-	.dev		= {
-		.platform_data	= &scif6_platform_data,
-	},
-};
+SH7372_SCIF(PORT_SCIFA, 0, 0xe6c40000, evt2irq(0x0c00));
+SH7372_SCIF(PORT_SCIFA, 1, 0xe6c50000, evt2irq(0x0c20));
+SH7372_SCIF(PORT_SCIFA, 2, 0xe6c60000, evt2irq(0x0c40));
+SH7372_SCIF(PORT_SCIFA, 3, 0xe6c70000, evt2irq(0x0c60));
+SH7372_SCIF(PORT_SCIFA, 4, 0xe6c80000, evt2irq(0x0d20));
+SH7372_SCIF(PORT_SCIFA, 5, 0xe6cb0000, evt2irq(0x0d40));
+SH7372_SCIF(PORT_SCIFB, 6, 0xe6c30000, evt2irq(0x0d60));
 
 /* CMT */
 static struct sh_timer_config cmt2_platform_data = {
-- 
1.8.4
