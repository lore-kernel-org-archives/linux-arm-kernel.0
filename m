From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 23 Aug 2011 17:18:07 -0300
Subject: [PATCH 2/2] ARM: imx: Add PATA clock support
In-Reply-To: <1314130687-27523-1-git-send-email-fabio.estevam@freescale.com>
References: <1314130687-27523-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1314130687-27523-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PATA clock support for MX27/MX31/MX35/MX53.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clock-imx27.c     |    4 ++--
 arch/arm/mach-imx/clock-imx31.c     |    4 ++--
 arch/arm/mach-imx/clock-imx35.c     |    4 ++--
 arch/arm/mach-mx5/clock-mx51-mx53.c |    1 +
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 6912b82..becc92e 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -583,7 +583,7 @@ DEFINE_CLOCK(emi_clk,      0, PCCR1, 19, NULL, NULL, &ahb_clk);
 DEFINE_CLOCK(dma_clk1,     0, PCCR1, 20, NULL, NULL, &ahb_clk);
 DEFINE_CLOCK(csi_clk1,     0, PCCR1, 21, NULL, NULL, &ahb_clk);
 DEFINE_CLOCK(brom_clk,     0, PCCR1, 22, NULL, NULL, &ahb_clk);
-DEFINE_CLOCK(ata_clk,      0, PCCR1, 23, NULL, NULL, &ahb_clk);
+DEFINE_CLOCK(pata_clk,      0, PCCR1, 23, NULL, NULL, &ahb_clk);
 DEFINE_CLOCK(wdog_clk,     0, PCCR1, 24, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(usb_clk,      0, PCCR1, 25, get_rate_usb, &usb_clk1, &spll_clk);
 DEFINE_CLOCK(uart6_clk1,   0, PCCR1, 26, NULL, NULL, &ipg_clk);
@@ -666,7 +666,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK(NULL, "emi", emi_clk)
 	_REGISTER_CLOCK(NULL, "sahara2", sahara2_clk)
-	_REGISTER_CLOCK(NULL, "ata", ata_clk)
+	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
 	_REGISTER_CLOCK(NULL, "mstick", mstick_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
index d973770..58ea0a8 100644
--- a/arch/arm/mach-imx/clock-imx31.c
+++ b/arch/arm/mach-imx/clock-imx31.c
@@ -476,7 +476,7 @@ DEFINE_CLOCK(gpt_clk,     0, MXC_CCM_CGR0,  4, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(epit1_clk,   0, MXC_CCM_CGR0,  6, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(epit2_clk,   1, MXC_CCM_CGR0,  8, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(iim_clk,     0, MXC_CCM_CGR0, 10, NULL, NULL, &ipg_clk);
-DEFINE_CLOCK(ata_clk,     0, MXC_CCM_CGR0, 12, NULL, NULL, &ipg_clk);
+DEFINE_CLOCK(pata_clk,     0, MXC_CCM_CGR0, 12, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(sdma_clk1,   0, MXC_CCM_CGR0, 14, NULL, NULL, &ahb_clk);
 DEFINE_CLOCK(cspi3_clk,   2, MXC_CCM_CGR0, 16, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(rng_clk,     0, MXC_CCM_CGR0, 18, NULL, NULL, &ipg_clk);
@@ -562,7 +562,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK(NULL, "firi", firi_clk)
-	_REGISTER_CLOCK(NULL, "ata", ata_clk)
+	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
 	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
 	_REGISTER_CLOCK(NULL, "rng", rng_clk)
 	_REGISTER_CLOCK("imx31-sdma", NULL, sdma_clk1)
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 88b62a0..c39f5c3 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -354,7 +354,7 @@ static void clk_cgr_disable(struct clk *clk)
 	}
 
 DEFINE_CLOCK(asrc_clk,   0, CCM_CGR0,  0, NULL, NULL);
-DEFINE_CLOCK(ata_clk,    0, CCM_CGR0,  2, get_rate_ipg, NULL);
+DEFINE_CLOCK(pata_clk,    0, CCM_CGR0,  2, get_rate_ipg, NULL);
 /* DEFINE_CLOCK(audmux_clk, 0, CCM_CGR0,  4, NULL, NULL); */
 DEFINE_CLOCK(can1_clk,   0, CCM_CGR0,  6, get_rate_ipg, NULL);
 DEFINE_CLOCK(can2_clk,   1, CCM_CGR0,  8, get_rate_ipg, NULL);
@@ -447,7 +447,7 @@ static struct clk nfc_clk = {
 
 static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "asrc", asrc_clk)
-	_REGISTER_CLOCK(NULL, "ata", ata_clk)
+	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
 	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi1_clk)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index b653133..3fcb596 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1508,6 +1508,7 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
 	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
+	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.6.0.4
