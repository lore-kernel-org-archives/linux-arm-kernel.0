From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:10 +0900
Subject: [PATCH 14/30] ARM: shmobile: sh7372: remove DIV4_ZT* clocks
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-15-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DIV4_ZT* clocks are for debugging and trace bus clock.
It is not necessary to control it from Linux/Software.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 45d21fe..6c23e3f 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -342,7 +342,7 @@ static struct clk_div4_table div4_table = {
 };
 
 enum { DIV4_I, DIV4_ZG, DIV4_B, DIV4_M1, DIV4_CSIR,
-       DIV4_ZTR, DIV4_ZT, DIV4_ZX, DIV4_HP,
+       DIV4_ZX, DIV4_HP,
        DIV4_ISPB, DIV4_S, DIV4_ZB, DIV4_ZB3, DIV4_CP,
        DIV4_DDRP, DIV4_NR };
 
@@ -355,8 +355,6 @@ static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_B] = DIV4(FRQCRA, 8, 0x6fff, CLK_ENABLE_ON_INIT),
 	[DIV4_M1] = DIV4(FRQCRA, 4, 0x6fff, CLK_ENABLE_ON_INIT),
 	[DIV4_CSIR] = DIV4(FRQCRA, 0, 0x6fff, 0),
-	[DIV4_ZTR] = DIV4(FRQCRB, 20, 0x6fff, 0),
-	[DIV4_ZT] = DIV4(FRQCRB, 16, 0x6fff, 0),
 	[DIV4_ZX] = DIV4(FRQCRB, 12, 0x6fff, 0),
 	[DIV4_HP] = DIV4(FRQCRB, 4, 0x6fff, 0),
 	[DIV4_ISPB] = DIV4(FRQCRC, 20, 0x6fff, 0),
@@ -516,8 +514,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("b_clk", &div4_clks[DIV4_B]),
 	CLKDEV_CON_ID("m1_clk", &div4_clks[DIV4_M1]),
 	CLKDEV_CON_ID("csir_clk", &div4_clks[DIV4_CSIR]),
-	CLKDEV_CON_ID("ztr_clk", &div4_clks[DIV4_ZTR]),
-	CLKDEV_CON_ID("zt_clk", &div4_clks[DIV4_ZT]),
 	CLKDEV_CON_ID("zx_clk", &div4_clks[DIV4_ZX]),
 	CLKDEV_CON_ID("hp_clk", &div4_clks[DIV4_HP]),
 	CLKDEV_CON_ID("ispb_clk", &div4_clks[DIV4_ISPB]),
-- 
1.7.10.4
