From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 28 Oct 2012 19:31:08 +0100
Subject: [PATCH v3 3/6] ARM: AT91: Add usart/tc/pio/ohci DT clock lookup to
 AT91RM9200
In-Reply-To: <1351449071-5763-1-git-send-email-manabian@gmail.com>
References: <1351449071-5763-1-git-send-email-manabian@gmail.com>
Message-ID: <1351449071-5763-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/mach-at91/at91rm9200.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index a3e4710..67bd9cd 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -188,12 +188,30 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91rm9200.0", &twi_clk),
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
+	CLKDEV_CON_DEV_ID("hclk", "300000.ohci", &ohci_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
 	CLKDEV_CON_ID("pioB", &pioB_clk),
 	CLKDEV_CON_ID("pioC", &pioC_clk),
 	CLKDEV_CON_ID("pioD", &pioD_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioA_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioB_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioC_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffffa00.gpio", &pioD_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
-- 
1.8.0
