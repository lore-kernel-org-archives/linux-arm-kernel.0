From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:09 +0900
Subject: [PATCH 13/30] ARM: shmobile: sh73a0: remove DIV4_ZT* clocks
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DIV4_ZT* clocks are for debugging and trace bus clock.
It is not necessary to control it from Linux/Software.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index a57ec15..26a5803 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -269,7 +269,7 @@ static struct clk_div4_table div4_table = {
 };
 
 enum { DIV4_I, DIV4_ZG, DIV4_M3, DIV4_B, DIV4_M1, DIV4_M2,
-	DIV4_Z, DIV4_ZTR, DIV4_ZT, DIV4_ZX, DIV4_HP, DIV4_NR };
+	DIV4_Z, DIV4_ZX, DIV4_HP, DIV4_NR };
 
 #define DIV4(_reg, _bit, _mask, _flags) \
 	SH_CLK_DIV4(&pll1_clk, _reg, _bit, _mask, _flags)
@@ -282,8 +282,6 @@ static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_M1] = DIV4(FRQCRA, 4, 0x1dff, 0),
 	[DIV4_M2] = DIV4(FRQCRA, 0, 0x1dff, 0),
 	[DIV4_Z] = SH_CLK_DIV4(&pll0_clk, FRQCRB, 24, 0x97f, 0),
-	[DIV4_ZTR] = DIV4(FRQCRB, 20, 0xdff, 0),
-	[DIV4_ZT] = DIV4(FRQCRB, 16, 0xdff, 0),
 	[DIV4_ZX] = DIV4(FRQCRB, 12, 0xdff, 0),
 	[DIV4_HP] = DIV4(FRQCRB, 4, 0xdff, 0),
 };
-- 
1.7.10.4
