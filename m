From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 8 Dec 2013 23:50:36 +0300
Subject: [PATCH v3 1/3] ARM: shmobile: r8a7791: add Ether clock
In-Reply-To: <201312082348.17588.sergei.shtylyov@cogentembedded.com>
References: <201312082348.17588.sergei.shtylyov@cogentembedded.com>
Message-ID: <201312082350.36871.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for R8A7791 Ether clock.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- changed "r8a779x-ether" wildcard device name to "r8a7791-ether";
- resolved rejects.

Changes in version 2:
- changed Ether device name to "r8a779x-ether".

 arch/arm/mach-shmobile/clock-r8a7791.c |    3 +++
 1 file changed, 3 insertions(+)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7791.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7791.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -122,6 +122,7 @@ static struct clk *main_clks[] = {
 
 /* MSTP */
 enum {
+	MSTP813,
 	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
 	MSTP522,
@@ -132,6 +133,7 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP724] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 24, 0), /* DU0 */
 	[MSTP723] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 23, 0), /* DU1 */
@@ -192,6 +194,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
+	CLKDEV_DEV_ID("r8a7791-ether", &mstp_clks[MSTP813]), /* Ether */
 };
 
 #define R8A7791_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
