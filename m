From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 20 Jul 2011 11:41:41 +0800
Subject: [PATCH v4 05/10] ARM: mxs: add saif clock
In-Reply-To: <1311133306-9496-1-git-send-email-b29396@freescale.com>
References: <1311133306-9496-1-git-send-email-b29396@freescale.com>
Message-ID: <1311133306-9496-6-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set pll0 as parent.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5dcc59d..7b3657b 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -640,6 +640,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "lradc", lradc_clk)
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
 	_REGISTER_CLOCK("imx28-fb", NULL, lcdif_clk)
+	_REGISTER_CLOCK("mxs-saif.0", NULL, saif0_clk)
+	_REGISTER_CLOCK("mxs-saif.1", NULL, saif1_clk)
 };
 
 static int clk_misc_init(void)
@@ -774,6 +776,8 @@ int __init mx28_clocks_init(void)
 	clk_enable(&uart_clk);
 
 	clk_set_parent(&lcdif_clk, &ref_pix_clk);
+	clk_set_parent(&saif0_clk, &pll0_clk);
+	clk_set_parent(&saif1_clk, &pll0_clk);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
-- 
1.7.0.4
