From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:55 +0900
Subject: [PATCH 05/11] ARM: shmobile: r8a7778: add support HSPI clock
In-Reply-To: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106861-25626-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds r8a7778 HSPI clock support.
It also adds shyway_clk which is requiested
from sh-hspi driver

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 1386c59..c2c1895 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -108,6 +108,7 @@ enum {
 	MSTP030,
 	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015,
+	MSTP007,
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
@@ -127,10 +128,12 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP021] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 21, 0), /* SCIF5 */
 	[MSTP016] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 16, 0), /* TMU0 */
 	[MSTP015] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 15, 0), /* TMU1 */
+	[MSTP007] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  7, 0), /* HSPI */
 };
 
 static struct clk_lookup lookups[] = {
 	/* main */
+	CLKDEV_CON_ID("shyway_clk",	&s_clk),
 	CLKDEV_CON_ID("peripheral_clk",	&p_clk),
 
 	/* MSTP32 clocks */
@@ -150,6 +153,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP015]), /* TMU01 */
+	CLKDEV_DEV_ID("sh-hspi.0", &mstp_clks[MSTP007]), /* HSPI0 */
+	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
+	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
 };
 
 void __init r8a7778_clock_init(void)
-- 
1.8.2.1
