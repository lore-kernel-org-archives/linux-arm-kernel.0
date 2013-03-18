From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:27 +0900
Subject: [PATCH 17/43] ARM: shmobile: sh73a0: fix Z and ZG clock hierarchy
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-18-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Z and ZG clocks on sh73a0 have pll0 as their parent, not pll1.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 5fa106b..71843dd 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -265,12 +265,12 @@ enum { DIV4_I, DIV4_ZG, DIV4_M3, DIV4_B, DIV4_M1, DIV4_M2,
 
 static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_I] = DIV4(FRQCRA, 20, 0xdff, CLK_ENABLE_ON_INIT),
-	[DIV4_ZG] = DIV4(FRQCRA, 16, 0xd7f, CLK_ENABLE_ON_INIT),
+	[DIV4_ZG] = SH_CLK_DIV4(&pll0_clk, FRQCRA, 16, 0xd7f, CLK_ENABLE_ON_INIT),
 	[DIV4_M3] = DIV4(FRQCRA, 12, 0x1dff, CLK_ENABLE_ON_INIT),
 	[DIV4_B] = DIV4(FRQCRA, 8, 0xdff, CLK_ENABLE_ON_INIT),
 	[DIV4_M1] = DIV4(FRQCRA, 4, 0x1dff, 0),
 	[DIV4_M2] = DIV4(FRQCRA, 0, 0x1dff, 0),
-	[DIV4_Z] = DIV4(FRQCRB, 24, 0x97f, 0),
+	[DIV4_Z] = SH_CLK_DIV4(&pll0_clk, FRQCRB, 24, 0x97f, 0),
 	[DIV4_ZTR] = DIV4(FRQCRB, 20, 0xdff, 0),
 	[DIV4_ZT] = DIV4(FRQCRB, 16, 0xdff, 0),
 	[DIV4_ZX] = DIV4(FRQCRB, 12, 0xdff, 0),
-- 
1.7.10.4
