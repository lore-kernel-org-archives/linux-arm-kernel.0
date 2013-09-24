From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 24 Sep 2013 19:30:32 +0200
Subject: [PATCH] ARM: at91: sama5d: add the PWM clock
Message-ID: <1380043832-26600-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/sama5d3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
index 4012797..8e43e8d 100644
--- a/arch/arm/mach-at91/sama5d3.c
+++ b/arch/arm/mach-at91/sama5d3.c
@@ -241,6 +241,11 @@ static struct clk tdes_clk = {
 	.pid		= SAMA5D3_ID_TDES,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
+static struct clk pwm_clk = {
+	.name		= "pwm_clk",
+	.pid		= SAMA5D3_ID_PWM,
+	.type		= CLK_TYPE_PERIPHERAL,
+};
 
 static struct clk *periph_clocks[] __initdata = {
 	&pioA_clk,
@@ -281,6 +286,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&sha_clk,
 	&aes_clk,
 	&tdes_clk,
+	&pwm_clk,
 };
 
 static struct clk pck0 = {
@@ -345,6 +351,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("sha_clk", "f8034000.sha", &sha_clk),
 	CLKDEV_CON_DEV_ID("aes_clk", "f8038000.aes", &aes_clk),
 	CLKDEV_CON_DEV_ID("tdes_clk", "f803c000.tdes", &tdes_clk),
+	CLKDEV_CON_DEV_ID(NULL, "f002c000.pwm", &pwm_clk),
 };
 
 static void __init sama5d3_register_clocks(void)
-- 
1.8.1.2
