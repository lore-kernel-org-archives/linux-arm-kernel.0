From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 22 Nov 2013 17:08:43 +0100
Subject: [PATCH v2] ARM: at91: sama5d3: reduce TWI internal clock frequency
Message-ID: <1385136523-11962-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

With some devices, transfer hangs during I2C frame transmission. This issue
disappears when reducing the internal frequency of the TWI IP. Even if it is
indicated that internal clock max frequency is 66MHz, it seems we have
oversampling on I2C signals making TWI believe that a transfer in progress
is done.

This fix has no impact on the I2C bus frequency.

Cc: <stable@vger.kernel.org> #3.10+
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

v2: update commit message

 arch/arm/mach-at91/sama5d3.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
index 4012797..4ee0de5 100644
--- a/arch/arm/mach-at91/sama5d3.c
+++ b/arch/arm/mach-at91/sama5d3.c
@@ -95,19 +95,19 @@ static struct clk twi0_clk = {
 	.name		= "twi0_clk",
 	.pid		= SAMA5D3_ID_TWI0,
 	.type		= CLK_TYPE_PERIPHERAL,
-	.div		= AT91_PMC_PCR_DIV2,
+	.div		= AT91_PMC_PCR_DIV8,
 };
 static struct clk twi1_clk = {
 	.name		= "twi1_clk",
 	.pid		= SAMA5D3_ID_TWI1,
 	.type		= CLK_TYPE_PERIPHERAL,
-	.div		= AT91_PMC_PCR_DIV2,
+	.div		= AT91_PMC_PCR_DIV8,
 };
 static struct clk twi2_clk = {
 	.name		= "twi2_clk",
 	.pid		= SAMA5D3_ID_TWI2,
 	.type		= CLK_TYPE_PERIPHERAL,
-	.div		= AT91_PMC_PCR_DIV2,
+	.div		= AT91_PMC_PCR_DIV8,
 };
 static struct clk mmc0_clk = {
 	.name		= "mci0_clk",
-- 
1.7.9.5
