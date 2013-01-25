From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:13:21 +0900
Subject: [PATCH 03/15] ARM: shmobile: sh73a0: fixup div4_clks bitmap
In-Reply-To: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080013-29189-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

div4_clks's bitmap of sh73a0 was wrong.
This patch is based on v2.0 datasheet.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 516ff7f..5f57701 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -264,17 +264,17 @@ enum { DIV4_I, DIV4_ZG, DIV4_M3, DIV4_B, DIV4_M1, DIV4_M2,
 	SH_CLK_DIV4(&pll1_clk, _reg, _bit, _mask, _flags)
 
 static struct clk div4_clks[DIV4_NR] = {
-	[DIV4_I] = DIV4(FRQCRA, 20, 0xfff, CLK_ENABLE_ON_INIT),
-	[DIV4_ZG] = DIV4(FRQCRA, 16, 0xbff, CLK_ENABLE_ON_INIT),
-	[DIV4_M3] = DIV4(FRQCRA, 12, 0xfff, CLK_ENABLE_ON_INIT),
-	[DIV4_B] = DIV4(FRQCRA, 8, 0xfff, CLK_ENABLE_ON_INIT),
-	[DIV4_M1] = DIV4(FRQCRA, 4, 0xfff, 0),
-	[DIV4_M2] = DIV4(FRQCRA, 0, 0xfff, 0),
-	[DIV4_Z] = DIV4(FRQCRB, 24, 0xbff, 0),
-	[DIV4_ZTR] = DIV4(FRQCRB, 20, 0xfff, 0),
-	[DIV4_ZT] = DIV4(FRQCRB, 16, 0xfff, 0),
-	[DIV4_ZX] = DIV4(FRQCRB, 12, 0xfff, 0),
-	[DIV4_HP] = DIV4(FRQCRB, 4, 0xfff, 0),
+	[DIV4_I] = DIV4(FRQCRA, 20, 0xdff, CLK_ENABLE_ON_INIT),
+	[DIV4_ZG] = DIV4(FRQCRA, 16, 0xd7f, CLK_ENABLE_ON_INIT),
+	[DIV4_M3] = DIV4(FRQCRA, 12, 0x1dff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(FRQCRA, 8, 0xdff, CLK_ENABLE_ON_INIT),
+	[DIV4_M1] = DIV4(FRQCRA, 4, 0x1dff, 0),
+	[DIV4_M2] = DIV4(FRQCRA, 0, 0x1dff, 0),
+	[DIV4_Z] = DIV4(FRQCRB, 24, 0x97f, 0),
+	[DIV4_ZTR] = DIV4(FRQCRB, 20, 0xdff, 0),
+	[DIV4_ZT] = DIV4(FRQCRB, 16, 0xdff, 0),
+	[DIV4_ZX] = DIV4(FRQCRB, 12, 0xdff, 0),
+	[DIV4_HP] = DIV4(FRQCRB, 4, 0xdff, 0),
 };
 
 enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_ZB1,
-- 
1.7.10.4
