From: baruch@tkos.co.il (Baruch Siach)
Date: Sun,  4 Jul 2010 11:47:29 +0300
Subject: [PATCH] mx25: set GPT clock source to PER
In-Reply-To: <20100704084343.GB19559@jasper.tkos.co.il>
References: <20100704084343.GB19559@jasper.tkos.co.il>
Message-ID: <40bc9462f125233cc9c63631a9b987ed684b6d97.1278233166.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes time accounting on mx25 base systems.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/time.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index f9a1b05..0d7e0f9 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -56,6 +56,7 @@
 /* MX31, MX35, MX25, MXC91231, MX5 */
 #define V2_TCTL_WAITEN		(1 << 3) /* Wait enable mode */
 #define V2_TCTL_CLK_IPG		(1 << 6)
+#define V2_TCTL_CLK_PER		(2 << 6)
 #define V2_TCTL_FRR		(1 << 9)
 #define V2_IR			0x0c
 #define V2_TSTAT		0x08
@@ -308,7 +309,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
 
 	if (timer_is_v2())
-		tctl_val = V2_TCTL_CLK_IPG | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+		tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
 	else
 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 
-- 
1.7.1
