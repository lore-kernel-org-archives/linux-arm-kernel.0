From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:12 +0100
Subject: [PATCH v3 08/15] at91: dt: sam9261: Added hclk declaration for the fb
 driver (non-CCF)
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-9-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CCF is not used the clocks are not described in the DTS. This patch adds
a clock required for the fb driver

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/at91sam9261.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 2c0e940..f17268f 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -199,6 +199,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	/* more tc lookup table for DT entries */
 	CLKDEV_CON_DEV_ID("t0_clk", "fffa0000.timer", &tc0_clk),
 	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &hck0),
+	CLKDEV_CON_DEV_ID("hclk", "600000.fb", &hck1),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffc8000.spi", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffcc000.spi", &spi1_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "fffa8000.mmc", &mmc_clk),
-- 
1.8.5.2
