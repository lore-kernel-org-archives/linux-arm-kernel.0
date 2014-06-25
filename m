From: denis@eukrea.com (Denis Carikli)
Date: Wed, 25 Jun 2014 14:41:34 +0200
Subject: [PATCH v3 1/3] ARM i.MX25 clk: Fix gpt timer clock.
Message-ID: <1403700096-13014-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpt0 timer clock has been wrong since:
  6bbaec5 ARM i.MX25: implement clocks using common clock framework

Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changelog v2->v3:
- DTS part splitted out
- Added Sascha's ack from the previous unsplitted patch.
- Added non-dt specific commit message.
- No code changes

Changelog v1->v2:
- Also fixed the ipg clock for non-dt init.
---
 arch/arm/mach-imx/clk-imx25.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 887b508..e759a6d 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -242,7 +242,7 @@ int __init mx25_clocks_init(void)
 {
 	__mx25_clocks_init(24000000);
 
-	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
+	clk_register_clkdev(clk[gpt1_ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
 	/* i.mx25 has the i.mx21 type uart */
 	clk_register_clkdev(clk[uart1_ipg], "ipg", "imx21-uart.0");
-- 
1.7.9.5
