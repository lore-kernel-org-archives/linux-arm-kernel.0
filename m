From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 15 Nov 2013 02:19:25 +0300
Subject: [PATCH v2 1/3] ARM: shmobile: r8a7791: add Ether clock
In-Reply-To: <201311150217.23563.sergei.shtylyov@cogentembedded.com>
References: <201311150217.23563.sergei.shtylyov@cogentembedded.com>
Message-ID: <201311150219.25520.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for R8A7791 Ether clock.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- changed Ether device name to "r8a779x-ether".

 arch/arm/mach-shmobile/clock-r8a7791.c |    3 +++
 1 file changed, 3 insertions(+)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7791.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7791.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -120,6 +120,7 @@ static struct clk *main_clks[] = {
 
 /* MSTP */
 enum {
+	MSTP813,
 	MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
 	MSTP216, MSTP207, MSTP206,
@@ -129,6 +130,7 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
 	[MSTP719] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 19, 0), /* SCIF2 */
@@ -180,6 +182,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.13", &mstp_clks[MSTP1106]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.14", &mstp_clks[MSTP1107]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
+	CLKDEV_DEV_ID("r8a779x-ether", &mstp_clks[MSTP813]), /* Ether */
 };
 
 #define R8A7791_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
