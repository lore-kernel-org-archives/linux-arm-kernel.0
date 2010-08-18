From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 18 Aug 2010 16:40:54 -0700
Subject: [PATCH 1/6] ARM: LPC32XX: Fix several clock device ID strings
In-Reply-To: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
References: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1282174859-8780-2-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

TBDs for I2S0 and I2S1 clocks are now NULL. Touch controller
device clock renamed to match &pdev->dev.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 32d6379..1659b3f 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1076,9 +1076,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
 	_REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
 	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
-	_REGISTER_CLOCK("tbd", "i2s0_ck", clk_i2s0)
-	_REGISTER_CLOCK("tbd", "i2s1_ck", clk_i2s1)
-	_REGISTER_CLOCK("lpc32xx-ts", NULL, clk_tsc)
+	_REGISTER_CLOCK(NULL, "i2s0_ck", clk_i2s0)
+	_REGISTER_CLOCK(NULL, "i2s1_ck", clk_i2s1)
+	_REGISTER_CLOCK("ts-lpc32xx", NULL, clk_tsc)
 	_REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
 	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
 	_REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
-- 
1.7.1.1
