From: tomi.valkeinen@iki.fi (Tomi Valkeinen)
Date: Tue, 11 Jun 2013 10:42:58 +0300
Subject: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
In-Reply-To: <20130610141451.GE8164@atomide.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
 <20130607162927.GA3331@atomide.com> <20130607175005.GB3331@atomide.com>
 <51B5ACA6.2010101@iki.fi> <20130610141451.GE8164@atomide.com>
Message-ID: <51B6D502.5010208@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/13 17:14, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@iki.fi> [130610 03:44]:

>> DSS does not have DT bindings, and removing DSS from hwmod data will
>> break DSS for omap4.
> 
> Ah that's right. Care to post a patch reverting the minimal parts that
> you need for omap4 against omap-for-v3.11/cleanup?

This one adds back the DSS data.

 Tomi


>From e23a18fe14cbfebf9b08e3004aec92e05a86a117 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Jun 2013 10:37:19 +0300
Subject: [PATCH] ARM: OMAP4: hwmod data: add DSS data back

Commit 3b9b10151c6838af52244cec4af41a938bb5b7ec (ARM: OMAP4: hwmod data:
Clean up the data file) removes hwmod data for omap4, including DSS
data. DSS has not yet been converted to DT, so the hwmod data is still
needed.

This patch adds back the DSS parts of the hwmod data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5f5d631..c8d4957 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -619,6 +619,16 @@ static struct omap_hwmod_class omap44xx_dispc_hwmod_class = {
 };
 
 /* dss_dispc */
+static struct omap_hwmod_irq_info omap44xx_dss_dispc_irqs[] = {
+	{ .irq = 25 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_dispc_sdma_reqs[] = {
+	{ .dma_req = 5 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_dss_dispc_dev_attr omap44xx_dss_dispc_dev_attr = {
 	.manager_count		= 3,
 	.has_framedonetv_irq	= 1
@@ -628,6 +638,8 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap44xx_dispc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.mpu_irqs	= omap44xx_dss_dispc_irqs,
+	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
@@ -660,6 +672,16 @@ static struct omap_hwmod_class omap44xx_dsi_hwmod_class = {
 };
 
 /* dss_dsi1 */
+static struct omap_hwmod_irq_info omap44xx_dss_dsi1_irqs[] = {
+	{ .irq = 53 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] = {
+	{ .dma_req = 74 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 };
@@ -668,6 +690,8 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.mpu_irqs	= omap44xx_dss_dsi1_irqs,
+	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
@@ -680,6 +704,16 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 };
 
 /* dss_dsi2 */
+static struct omap_hwmod_irq_info omap44xx_dss_dsi2_irqs[] = {
+	{ .irq = 84 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] = {
+	{ .dma_req = 83 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod_opt_clk dss_dsi2_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 };
@@ -688,6 +722,8 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.name		= "dss_dsi2",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.mpu_irqs	= omap44xx_dss_dsi2_irqs,
+	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
@@ -720,6 +756,16 @@ static struct omap_hwmod_class omap44xx_hdmi_hwmod_class = {
 };
 
 /* dss_hdmi */
+static struct omap_hwmod_irq_info omap44xx_dss_hdmi_irqs[] = {
+	{ .irq = 101 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] = {
+	{ .dma_req = 75 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 };
@@ -733,6 +779,8 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	 * set idle mode by software.
 	 */
 	.flags		= HWMOD_SWSUP_SIDLE,
+	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
+	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
 		.omap4 = {
@@ -765,6 +813,11 @@ static struct omap_hwmod_class omap44xx_rfbi_hwmod_class = {
 };
 
 /* dss_rfbi */
+static struct omap_hwmod_dma_info omap44xx_dss_rfbi_sdma_reqs[] = {
+	{ .dma_req = 13 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
 	{ .role = "ick", .clk = "dss_fck" },
 };
@@ -773,6 +826,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap44xx_rfbi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.sdma_reqs	= omap44xx_dss_rfbi_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
-- 
1.8.1.2



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/7eafc727/attachment-0001.sig>
