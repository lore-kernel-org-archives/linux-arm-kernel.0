From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:31:11 +0000
Subject: [PATCH 26/31] ARM: amba: netx: use common amba device initializers
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAoR-0005G2-1Y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-netx/fb.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
index eda856c..2cdf6ef 100644
--- a/arch/arm/mach-netx/fb.c
+++ b/arch/arm/mach-netx/fb.c
@@ -92,18 +92,7 @@ void clk_put(struct clk *clk)
 {
 }
 
-static struct amba_device fb_device = {
-	.dev		= {
-		.init_name = "fb",
-		.coherent_dma_mask = ~0,
-	},
-	.res		= {
-		.start	= 0x00104000,
-		.end	= 0x00104fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { NETX_IRQ_LCD },
-};
+static AMBA_AHB_DEVICE(fb, "fb", 0, 0x00104000, { NETX_IRQ_LCD }, NULL);
 
 int netx_fb_init(struct clcd_board *board, struct clcd_panel *panel)
 {
-- 
1.7.4.4
