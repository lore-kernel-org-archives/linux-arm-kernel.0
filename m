From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 2 Jun 2011 01:36:09 +0200
Subject: [PATCH RFC] at91: Use "pclk" as con_id on at91cap9 and at91rm9200
Message-ID: <BANLkTikDJhE6dbGmz5QAgEJeKRknp2jDpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am not 100% sure this is the right thing to do, but it makes the
atmel-ssc driver happy on my at91rm9200 board.



This unifies the con_id across all at91 machines.

The atmel-ssc driver expects the con_id to be "pclk" or it will fail probing.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
---
 arch/arm/mach-at91/at91cap9.c   |    4 ++--
 arch/arm/mach-at91/at91rm9200.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 17fae4a..de5d7cd 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -230,8 +230,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
-	CLKDEV_CON_DEV_ID("ssc", "ssc.0", &ssc0_clk),
-	CLKDEV_CON_DEV_ID("ssc", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 };

 static struct clk_lookup usart_clocks_lookups[] = {
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index b228ce9..83a1a3f 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -199,9 +199,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tc3_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
-	CLKDEV_CON_DEV_ID("ssc", "ssc.0", &ssc0_clk),
-	CLKDEV_CON_DEV_ID("ssc", "ssc.1", &ssc1_clk),
-	CLKDEV_CON_DEV_ID("ssc", "ssc.2", &ssc2_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
 };

 static struct clk_lookup usart_clocks_lookups[] = {
-- 
1.7.5.2
