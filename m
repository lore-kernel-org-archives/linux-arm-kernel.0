From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  6 Aug 2013 16:50:09 +0900
Subject: [PATCH v7 1/3] ARM: shmobile: r8a7790: clocks for Ether support
In-Reply-To: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
References: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1375775411-4545-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v5
* Split out from "ARM: shmobile: r8a7790: add Ether support"
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 50d96f9..fc36d3d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -51,6 +51,7 @@
 #define SMSTPCR3 0xe615013c
 #define SMSTPCR5 0xe6150144
 #define SMSTPCR7 0xe615014c
+#define SMSTPCR8 0xe6150990
 
 #define SDCKCR		0xE6150074
 #define SD2CKCR		0xE6150078
@@ -180,6 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP813,
 	MSTP721, MSTP720,
 	MSTP717, MSTP716,
 	MSTP522,
@@ -190,6 +192,7 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
 	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
@@ -258,6 +261,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
+	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
-- 
1.8.3.2
