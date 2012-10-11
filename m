From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 12 Oct 2012 00:05:24 +0200
Subject: [PATCH 2/4] ARM: AT91: Add usart/tc DT clock lookup to AT91RM9200
In-Reply-To: <1349993126-9519-1-git-send-email-manabian@gmail.com>
References: <1349993126-9519-1-git-send-email-manabian@gmail.com>
Message-ID: <1349993126-9519-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/mach-at91/at91rm9200.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index b4f0565..eef3f53 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -188,6 +188,19 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91rm9200", &twi_clk),
+	/* usart lookup table for DT entries */
+	CLKDEV_CON_DEV_ID("usart", "fffff200.serial", &mck),
+	CLKDEV_CON_DEV_ID("usart", "fffc0000.serial", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "fffc4000.serial", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "fffc8000.serial", &usart2_clk),
+	CLKDEV_CON_DEV_ID("usart", "fffcc000.serial", &usart3_clk),
+	/* tc lookup table for DT entries */
+	CLKDEV_CON_DEV_ID("t0_clk", "fffa0000.timer", &tc0_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "fffa0000.timer", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "fffa0000.timer", &tc2_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "fffa4000.timer", &tc3_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "fffa4000.timer", &tc4_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "fffa4000.timer", &tc5_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
-- 
1.7.12.2
