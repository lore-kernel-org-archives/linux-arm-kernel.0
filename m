From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 16 Nov 2010 10:36:21 -0800 (PST)
Subject: [PATCH 2/5] mx51: Add PWM clock support
Message-ID: <942655.99898.qm@web51002.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51.c |? ? 8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 8ac36d8..0624c4f 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -1046,6 +1046,12 @@ DEFINE_CLOCK_FULL(esdhc2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG2_OFFSET,
 DEFINE_CLOCK_MAX(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
 ??? clk_esdhc2, &pll2_sw_clk, &esdhc2_ipg_clk);
 
+/* PWM */
+DEFINE_CLOCK(pwm1_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG5_OFFSET,
+??? NULL, NULL, &ipg_clk, NULL);
+DEFINE_CLOCK(pwm2_clk, 1, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG7_OFFSET,
+??? NULL, NULL, &ipg_clk, NULL);
+
 #define _REGISTER_CLOCK(d, n, c) \
? ? ? ? { \
 ??? ??? .dev_id = d, \
@@ -1082,6 +1088,8 @@ static struct clk_lookup lookups[] = {
 ??? _REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
 ??? _REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
 ??? _REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
+??? _REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
+??? _REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.6.0.4





      
