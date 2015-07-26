From: tremyfr@gmail.com (Philippe Reynes)
Date: Sun, 26 Jul 2015 23:37:48 +0200
Subject: [PATCH v5 1/6] imx31: add a second rtc clock
In-Reply-To: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
References: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1437946673-7402-2-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc rtc driver needs two clock.
It was defined only one clock, so we
define the second clock.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/clk/imx/clk-imx31.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index fe66c40..1f83834 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -147,7 +147,8 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[cspi3_gate], NULL, "imx31-cspi.2");
 	clk_register_clkdev(clk[pwm_gate], "pwm", NULL);
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[rtc_gate], NULL, "imx21-rtc");
+	clk_register_clkdev(clk[ckil], "ref", "imx21-rtc");
+	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
 	clk_register_clkdev(clk[epit1_gate], "epit", NULL);
 	clk_register_clkdev(clk[epit2_gate], "epit", NULL);
 	clk_register_clkdev(clk[nfc], NULL, "imx27-nand.0");
-- 
1.7.4.4
