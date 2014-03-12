From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 12 Mar 2014 10:43:37 +0100
Subject: [PATCHv5 1/9] ARM: at91: prepare at91sam9rl DT transition
In-Reply-To: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394617425-641-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new names, coming from DT, for the clock lookups.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9rl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 3651517abedf..4b6eb2df601a 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -196,6 +196,23 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_ID("pioB", &pioB_clk),
 	CLKDEV_CON_ID("pioC", &pioC_clk),
 	CLKDEV_CON_ID("pioD", &pioD_clk),
+	/* more lookup table for DT entries */
+	CLKDEV_CON_DEV_ID("usart", "fffff200.serial", &mck),
+	CLKDEV_CON_DEV_ID("usart", "fffb0000.serial", &usart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "ffffb400.serial", &usart1_clk),
+	CLKDEV_CON_DEV_ID("usart", "ffffb800.serial", &usart2_clk),
+	CLKDEV_CON_DEV_ID("usart", "ffffbc00.serial", &usart3_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "fffa0000.timer", &tc0_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "fffa0000.timer", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "fffa0000.timer", &tc2_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "fffa4000.mmc", &mmc_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffa8000.i2c", &twi0_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffac000.i2c", &twi1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "ffffc800.pwm", &pwm_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioA_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioB_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioC_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffffa00.gpio", &pioD_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
-- 
1.8.3.2
