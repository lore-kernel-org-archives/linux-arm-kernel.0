From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Jun 2013 17:40:40 +0900
Subject: [PATCH v2 2/2] ARM: shmobile: r8a73a4: add clocks for thermal
In-Reply-To: <1372236040-16737-1-git-send-email-horms+renesas@verge.net.au>
References: <1372236040-16737-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1372236040-16737-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 5d71313..28eccd1 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -49,6 +49,7 @@
 
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR3 0xe615013c
+#define SMSTPCR5 0xe6150144
 #define SMSTPCR7 0xe615014c
 
 #define MODEMR		0xE6160060
@@ -182,6 +183,7 @@ static struct clk div6_clks[DIV6_NR] = {
 enum {
 	MSTP721, MSTP720,
 	MSTP717, MSTP716,
+	MSTP522,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
 	MSTP_NR
@@ -203,6 +205,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP204] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
 	[MSTP203] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
 	[MSTP202] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 2, 0), /* SCIFA2 */
+	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
 	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
 	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
 };
@@ -254,6 +257,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
+	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]),
-- 
1.8.2.1
