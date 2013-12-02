From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Dec 2013 11:19:19 +0900
Subject: [PATCH 13/28] ARM: shmobile: r8a7790: add QSPI support
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
Message-ID: <7df76f23cc85718cd2bd7460781a20b090ca2c24.1385950394.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Adds support for QSPI on the r8a7790.

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 161d44e..5269640 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -183,6 +183,7 @@ static struct clk div6_clks[DIV6_NR] = {
 /* MSTP */
 enum {
 	MSTP931, MSTP930, MSTP929, MSTP928,
+	MSTP917,
 	MSTP813,
 	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
 	MSTP717, MSTP716,
@@ -199,6 +200,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP930] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 30, 0), /* I2C1 */
 	[MSTP929] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 29, 0), /* I2C2 */
 	[MSTP928] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 28, 0), /* I2C3 */
+	[MSTP917] = SH_CLK_MSTP32(&qspi_clk, SMSTPCR9, 17, 0), /* QSPI */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP725] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 25, 0), /* LVDS1 */
@@ -298,6 +300,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
+	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
 	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
 	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
 };
-- 
1.8.4
