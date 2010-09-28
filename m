From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Sep 2010 14:48:43 +0900
Subject: [PATCH] ARM: S5P: Remove the unused clk_arm clock from plat-s5p
Message-ID: <1285652923-28502-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

All the S5P series SoCs use the 'struct clksrc_clk' type to represent the
armclk. So the clk_arm clock instance available in the plat-s5p clock code
is not used in any of the S5P series SoCs.
This patch removes the unused clk_arm instance from plat-s5p clock code.

Reported-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/clock.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index 8aaf4e6..8188009 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -88,14 +88,6 @@ struct clk clk_fout_vpll = {
 	.ctrlbit	= (1 << 31),
 };
 
-/* ARM clock */
-struct clk clk_arm = {
-	.name		= "armclk",
-	.id		= -1,
-	.rate		= 0,
-	.ctrlbit	= 0,
-};
-
 /* Possible clock sources for APLL Mux */
 static struct clk *clk_src_apll_list[] = {
 	[0] = &clk_fin_apll,
@@ -165,7 +157,6 @@ static struct clk *s5p_clks[] __initdata = {
 	&clk_fout_epll,
 	&clk_fout_dpll,
 	&clk_fout_vpll,
-	&clk_arm,
 	&clk_vpll,
 	&clk_xusbxti,
 };
-- 
1.6.2.5
