From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:18 -0500
Subject: [PATCH 03/18] ARM: imx: Add an array of timer IP block versions
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-4-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added an array to record the relationship between the
compatible string and the version of timer IP block.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 5df3c53..f44c2aa 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -372,6 +372,23 @@ void __init mxc_timer_init(unsigned long pbase, int irq, int ver)
 	_mxc_timer_init(irq, clk_per, clk_ipg);
 }
 
+struct imx_timer_ip_combo {
+	const char      *compat;
+	int             version;
+};
+
+static const struct imx_timer_ip_combo imx_timer_tables[] = {
+	{"fsl,imx1-gpt",        IMX_TIMER_V0},
+	{"fsl,imx25-gpt",       IMX_TIMER_V2},
+	{"fsl,imx25-gpt",       IMX_TIMER_V2},
+	{"fsl,imx50-gpt",       IMX_TIMER_V2},
+	{"fsl,imx51-gpt",       IMX_TIMER_V2},
+	{"fsl,imx53-gpt",       IMX_TIMER_V2},
+	{"fsl,imx6q-gpt",       IMX_TIMER_V2},
+	{"fsl,imx6sl-gpt",      IMX_TIMER_V3},
+	{"fsl,imx6sx-gpt",      IMX_TIMER_V3},
+};
+
 static void __init mxc_timer_init_dt(struct device_node *np)
 {
 	struct clk *clk_per, *clk_ipg;
-- 
1.9.1
