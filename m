From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:53 +0900
Subject: [PATCH 03/11] ARM: shmobile: r8a7790: HSCIF support
In-Reply-To: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106861-25626-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

Adds support for HSCIF0 and HSCIF1 on the r8a7790.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index b393592..379bce6 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -181,6 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
 /* MSTP */
 enum {
 	MSTP721, MSTP720,
+	MSTP717, MSTP716,
 	MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
 	MSTP_NR
@@ -196,6 +197,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP204] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
 	[MSTP203] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
 	[MSTP202] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 2, 0), /* SCIFA2 */
+	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
+	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
 };
 
 static struct clk_lookup lookups[] = {
@@ -249,6 +252,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
+	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
+	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
-- 
1.8.2.1
