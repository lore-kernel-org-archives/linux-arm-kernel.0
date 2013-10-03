From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu,  3 Oct 2013 12:05:02 +0200
Subject: [PATCH v2] clk: armada-370: fix tclk frequencies
Message-ID: <1380794702-6191-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the tclk frequency array for the Armada-370 SoC.
This bug has been introduced by commit 6b72333d
("clk: mvebu: add Armada 370 SoC-centric clock init").

A wrong tclk frequency affects the following drivers: mvsdio, mvneta,
i2c-mv64xxx and mvebu-devbus. This list may be incomplete.

About the mvneta Ethernet driver, note that the tclk frequency is used
to compute the Rx time coalescence. Then, this bug harms the coalescence
configuration and also degrades the networking performances with the
default values.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: stable at vger.kernel.org
---
 drivers/clk/mvebu/armada-370.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index fc777bd..81a202d 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -39,8 +39,8 @@ static const struct coreclk_ratio a370_coreclk_ratios[] __initconst = {
 };
 
 static const u32 a370_tclk_freqs[] __initconst = {
-	16600000,
-	20000000,
+	166000000,
+	200000000,
 };
 
 static u32 __init a370_get_tclk_freq(void __iomem *sar)
-- 
1.7.10.4
