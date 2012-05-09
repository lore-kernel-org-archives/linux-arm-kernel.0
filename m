From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 May 2012 11:06:02 +0200
Subject: [PATCH 5/9] Add clocks for X5 boards
In-Reply-To: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1336554366-16957-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-at91/at91sam9x5.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 13c8cae..1b144b4 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -120,6 +120,11 @@ static struct clk adc_clk = {
 	.pmc_mask	= 1 << AT91SAM9X5_ID_ADC,
 	.type	= CLK_TYPE_PERIPHERAL,
 };
+static struct clk adc_op_clk = {
+	.name		= "adc_op_clk",
+	.type		= CLK_TYPE_PERIPHERAL,
+	.rate_hz	= 5000000,
+};
 static struct clk dma0_clk = {
 	.name		= "dma0_clk",
 	.pmc_mask	= 1 << AT91SAM9X5_ID_DMA0,
@@ -205,6 +210,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&tcb0_clk,
 	&pwm_clk,
 	&adc_clk,
+	&adc_op_clk,
 	&dma0_clk,
 	&dma1_clk,
 	&uhphs_clk,
-- 
1.7.9.5
