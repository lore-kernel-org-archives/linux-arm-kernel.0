From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:46 +0900
Subject: [PATCH 05/12] ARM: shmobile: r8a7740: Make private clock arrays static
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Both clock-r8a7740.c and clock-r8a7790.c define a div4_clks array as
non-static. Compiling support for both SoCs thus result in a symbol
redefinition. Fix it by defining the arrays as static.

To avoid further similar issues, also define the main_clks as static.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 8fc396a..a2a612f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -266,7 +266,7 @@ static struct clk fsiack_clk = {
 static struct clk fsibck_clk = {
 };
 
-struct clk *main_clks[] = {
+static struct clk *main_clks[] = {
 	&extalr_clk,
 	&extal1_clk,
 	&extal2_clk,
@@ -317,7 +317,7 @@ enum {
 	DIV4_NR
 };
 
-struct clk div4_clks[DIV4_NR] = {
+static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_I]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT),
 	[DIV4_ZG]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT),
 	[DIV4_B]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA,  8, 0x6fff, CLK_ENABLE_ON_INIT),
-- 
1.7.10.4
