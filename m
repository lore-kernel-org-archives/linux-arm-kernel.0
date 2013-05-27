From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:53 +0900
Subject: [PATCH 12/12] ARM: shmobile: clock-r8a7740: add TPU PWM support
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index b12c476..6ad4640 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -461,7 +461,7 @@ enum {
 
 	MSTP329, MSTP328, MSTP323, MSTP320,
 	MSTP314, MSTP313, MSTP312,
-	MSTP309,
+	MSTP309, MSTP304,
 
 	MSTP416, MSTP415, MSTP407, MSTP406,
 
@@ -499,6 +499,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 12, 0), /* MMC */
 	[MSTP309] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3,  9, 0), /* GEther */
+	[MSTP304] = SH_CLK_MSTP32(&div4_clks[DIV4_CP],	SMSTPCR3,  4, 0), /* TPU0 */
 
 	[MSTP416] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 16, 0), /* USBHOST */
 	[MSTP415] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 15, 0), /* SDHI2 */
@@ -596,6 +597,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
+	CLKDEV_DEV_ID("renesas_tpu_pwm",	&mstp_clks[MSTP304]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),
-- 
1.7.10.4
