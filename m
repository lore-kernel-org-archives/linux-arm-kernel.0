From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:00:24 +0900
Subject: [PATCH 7/7] ARM: shmobile: clock-r8a7790: add TPU PWM support
In-Reply-To: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645224-3728-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index bedd20c..b393592 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -48,6 +48,7 @@
 #define CPG_LEN 0x1000
 
 #define SMSTPCR2 0xe6150138
+#define SMSTPCR3 0xe615013c
 #define SMSTPCR7 0xe615014c
 
 #define MODEMR		0xE6160060
@@ -178,11 +179,17 @@ static struct clk div6_clks[DIV6_NR] = {
 };
 
 /* MSTP */
-enum { MSTP721, MSTP720,
-	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP_NR };
+enum {
+	MSTP721, MSTP720,
+	MSTP304,
+	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
+	MSTP_NR
+};
+
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
+	[MSTP304] = SH_CLK_MSTP32(&cp_clk, SMSTPCR3, 4, 0), /* TPU0 */
 	[MSTP216] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
 	[MSTP207] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 7, 0), /* SCIFB1 */
 	[MSTP206] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 6, 0), /* SCIFB0 */
-- 
1.7.10.4
