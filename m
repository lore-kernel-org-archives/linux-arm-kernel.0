From: jamie@jamieiles.com (Jamie Iles)
Date: Tue,  9 Aug 2011 10:16:43 +0100
Subject: [PATCHv3 1/9] at91: provide macb clks with "pclk" and "hclk" name
In-Reply-To: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312881411-2376-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macb driver expects clocks with the names "pclk" and "hclk".  We
currently provide "macb_clk" but to fit in line with other
architectures (namely AVR32), provide "pclk" and a fake "hclk".

Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9.c    |    8 +++++++-
 arch/arm/mach-at91/at91sam9260.c |    8 +++++++-
 arch/arm/mach-at91/at91sam9263.c |    8 +++++++-
 arch/arm/mach-at91/at91sam9g45.c |    8 +++++++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index bfc6844..da17a72 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -137,10 +137,15 @@ static struct clk pwm_clk = {
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
+	.name		= "pclk",
 	.pmc_mask	= 1 << AT91CAP9_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
+static struct clk macb_hclk = {
+	.name		= "hclk",
+	.pmc_mask	= 0,
+	.type		= CLK_TYPE_PERIPHERAL,
+};
 static struct clk aestdes_clk = {
 	.name		= "aestdes_clk",
 	.pmc_mask	= 1 << AT91CAP9_ID_AESTDES,
@@ -199,6 +204,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&tcb_clk,
 	&pwm_clk,
 	&macb_clk,
+	&macb_hclk,
 	&aestdes_clk,
 	&adc_clk,
 	&isi_clk,
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index cb397be..d4e70cd 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -120,10 +120,15 @@ static struct clk ohci_clk = {
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
+	.name		= "pclk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
+static struct clk macb_hclk = {
+	.name		= "hclk",
+	.pmc_mask	= 0,
+	.type		= CLK_TYPE_PERIPHERAL,
+};
 static struct clk isi_clk = {
 	.name		= "isi_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_ISI,
@@ -179,6 +184,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&tc2_clk,
 	&ohci_clk,
 	&macb_clk,
+	&macb_hclk,
 	&isi_clk,
 	&usart3_clk,
 	&usart4_clk,
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 044f3c9..ff4ddd3 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -118,10 +118,15 @@ static struct clk pwm_clk = {
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
+	.name		= "pclk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
+static struct clk macb_hclk = {
+	.name		= "hclk",
+	.pmc_mask	= 0,
+	.type		= CLK_TYPE_PERIPHERAL,
+};
 static struct clk dma_clk = {
 	.name		= "dma_clk",
 	.pmc_mask	= 1 << AT91SAM9263_ID_DMA,
@@ -172,6 +177,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&tcb_clk,
 	&pwm_clk,
 	&macb_clk,
+	&macb_hclk,
 	&twodge_clk,
 	&udc_clk,
 	&isi_clk,
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index e04c5fb..3726d1b 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -144,10 +144,15 @@ static struct clk ac97_clk = {
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk macb_clk = {
-	.name		= "macb_clk",
+	.name		= "pclk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_EMAC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
+static struct clk macb_hclk = {
+	.name		= "hclk",
+	.pmc_mask	= 0,
+	.type		= CLK_TYPE_PERIPHERAL,
+};
 static struct clk isi_clk = {
 	.name		= "isi_clk",
 	.pmc_mask	= 1 << AT91SAM9G45_ID_ISI,
@@ -195,6 +200,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&lcdc_clk,
 	&ac97_clk,
 	&macb_clk,
+	&macb_hclk,
 	&isi_clk,
 	&udphs_clk,
 	&mmc1_clk,
-- 
1.7.4.1
