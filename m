From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 12:55:33 +0900
Subject: [PATCH 15/15] ARM: shmobile: r8a7779: scif .irqs used SCIx_IRQ_MUXED()
In-Reply-To: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
References: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359086133-23357-16-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch tidyup scif .irqs settings by using
SCIx_IRQ_MUXED() macro.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index a181ced..7e87ab3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -66,8 +66,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(88), gic_spi(88),
-			    gic_spi(88), gic_spi(88) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(88)),
 };
 
 static struct platform_device scif0_device = {
@@ -84,8 +83,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(89), gic_spi(89),
-			    gic_spi(89), gic_spi(89) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(89)),
 };
 
 static struct platform_device scif1_device = {
@@ -102,8 +100,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(90), gic_spi(90),
-			    gic_spi(90), gic_spi(90) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(90)),
 };
 
 static struct platform_device scif2_device = {
@@ -120,8 +117,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(91), gic_spi(91),
-			    gic_spi(91), gic_spi(91) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(91)),
 };
 
 static struct platform_device scif3_device = {
@@ -138,8 +134,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(92), gic_spi(92),
-			    gic_spi(92), gic_spi(92) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(92)),
 };
 
 static struct platform_device scif4_device = {
@@ -156,8 +151,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(93), gic_spi(93),
-			    gic_spi(93), gic_spi(93) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(93)),
 };
 
 static struct platform_device scif5_device = {
-- 
1.7.10.4
