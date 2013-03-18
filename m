From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:29 +0900
Subject: [PATCH 37/43] ARM: shmobile: r8a7779: use gic_iid macro
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-38-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

"ARM: shmobile: add gic_iid macro for ICCIAR / interrupt ID"
enabled to use gic_iid macro.
This patch exchange current GIC interrupt setting
from gic_spi() to gic_iid()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[ horms+renesas at verge.net.au: Updated git commit id in changelog ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 9322858..0068b9f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -92,7 +92,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(88)),
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x78)),
 };
 
 static struct platform_device scif0_device = {
@@ -109,7 +109,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(89)),
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x79)),
 };
 
 static struct platform_device scif1_device = {
@@ -126,7 +126,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(90)),
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x7a)),
 };
 
 static struct platform_device scif2_device = {
@@ -143,7 +143,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(91)),
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x7b)),
 };
 
 static struct platform_device scif3_device = {
@@ -160,7 +160,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(92)),
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x7c)),
 };
 
 static struct platform_device scif4_device = {
@@ -177,7 +177,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= SCIx_IRQ_MUXED(gic_spi(93)),
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x7d)),
 };
 
 static struct platform_device scif5_device = {
@@ -204,7 +204,7 @@ static struct resource tmu00_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(32),
+		.start	= gic_iid(0x40),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -234,7 +234,7 @@ static struct resource tmu01_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(33),
+		.start	= gic_iid(0x41),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -256,7 +256,7 @@ static struct resource rcar_i2c0_res[] = {
 		.end    = 0xffc70fff,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = gic_spi(79),
+		.start  = gic_iid(0x6f),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -274,7 +274,7 @@ static struct resource rcar_i2c1_res[] = {
 		.end    = 0xffc71fff,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = gic_spi(82),
+		.start  = gic_iid(0x72),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -292,7 +292,7 @@ static struct resource rcar_i2c2_res[] = {
 		.end    = 0xffc72fff,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = gic_spi(80),
+		.start  = gic_iid(0x70),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -310,7 +310,7 @@ static struct resource rcar_i2c3_res[] = {
 		.end    = 0xffc73fff,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = gic_spi(81),
+		.start  = gic_iid(0x71),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
-- 
1.7.10.4
