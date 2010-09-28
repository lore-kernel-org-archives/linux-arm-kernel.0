From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 28 Sep 2010 22:13:45 +0200
Subject: [PATCH 1/5] ARM: imx/clock-imx27: Pass NULL as function callback,
	not 0
In-Reply-To: <20100928201230.GJ26352@pengutronix.de>
References: <20100928201230.GJ26352@pengutronix.de>
Message-ID: <1285704829-29406-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes many sparse warnings like:

	arch/arm/mach-imx/clock-imx27.c:597:1: warning: Using plain integer as NULL pointer

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/clock-imx27.c |   42 +++++++++++++++++++-------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 07bf315..98a25ba 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -594,27 +594,27 @@ DEFINE_CLOCK(uart2_clk1,   0, PCCR1, 30, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(uart1_clk1,   0, PCCR1, 31, NULL, NULL, &ipg_clk);
 
 /* Clocks we cannot directly gate, but drivers need their rates */
-DEFINE_CLOCK(cspi1_clk,    0, 0,      0, NULL, &cspi1_clk1, &per2_clk);
-DEFINE_CLOCK(cspi2_clk,    1, 0,      0, NULL, &cspi2_clk1, &per2_clk);
-DEFINE_CLOCK(cspi3_clk,    2, 0,      0, NULL, &cspi13_clk1, &per2_clk);
-DEFINE_CLOCK(sdhc1_clk,    0, 0,      0, NULL, &sdhc1_clk1, &per2_clk);
-DEFINE_CLOCK(sdhc2_clk,    1, 0,      0, NULL, &sdhc2_clk1, &per2_clk);
-DEFINE_CLOCK(sdhc3_clk,    2, 0,      0, NULL, &sdhc3_clk1, &per2_clk);
-DEFINE_CLOCK(pwm_clk,      0, 0,      0, NULL, &pwm_clk1, &per1_clk);
-DEFINE_CLOCK(gpt1_clk,     0, 0,      0, NULL, &gpt1_clk1, &per1_clk);
-DEFINE_CLOCK(gpt2_clk,     1, 0,      0, NULL, &gpt2_clk1, &per1_clk);
-DEFINE_CLOCK(gpt3_clk,     2, 0,      0, NULL, &gpt3_clk1, &per1_clk);
-DEFINE_CLOCK(gpt4_clk,     3, 0,      0, NULL, &gpt4_clk1, &per1_clk);
-DEFINE_CLOCK(gpt5_clk,     4, 0,      0, NULL, &gpt5_clk1, &per1_clk);
-DEFINE_CLOCK(gpt6_clk,     5, 0,      0, NULL, &gpt6_clk1, &per1_clk);
-DEFINE_CLOCK(uart1_clk,    0, 0,      0, NULL, &uart1_clk1, &per1_clk);
-DEFINE_CLOCK(uart2_clk,    1, 0,      0, NULL, &uart2_clk1, &per1_clk);
-DEFINE_CLOCK(uart3_clk,    2, 0,      0, NULL, &uart3_clk1, &per1_clk);
-DEFINE_CLOCK(uart4_clk,    3, 0,      0, NULL, &uart4_clk1, &per1_clk);
-DEFINE_CLOCK(uart5_clk,    4, 0,      0, NULL, &uart5_clk1, &per1_clk);
-DEFINE_CLOCK(uart6_clk,    5, 0,      0, NULL, &uart6_clk1, &per1_clk);
-DEFINE_CLOCK1(lcdc_clk,    0, 0,      0, parent, &lcdc_clk1, &per3_clk);
-DEFINE_CLOCK1(csi_clk,     0, 0,      0, parent, &csi_clk1, &per4_clk);
+DEFINE_CLOCK(cspi1_clk,    0, NULL,   0, NULL, &cspi1_clk1, &per2_clk);
+DEFINE_CLOCK(cspi2_clk,    1, NULL,   0, NULL, &cspi2_clk1, &per2_clk);
+DEFINE_CLOCK(cspi3_clk,    2, NULL,   0, NULL, &cspi13_clk1, &per2_clk);
+DEFINE_CLOCK(sdhc1_clk,    0, NULL,   0, NULL, &sdhc1_clk1, &per2_clk);
+DEFINE_CLOCK(sdhc2_clk,    1, NULL,   0, NULL, &sdhc2_clk1, &per2_clk);
+DEFINE_CLOCK(sdhc3_clk,    2, NULL,   0, NULL, &sdhc3_clk1, &per2_clk);
+DEFINE_CLOCK(pwm_clk,      0, NULL,   0, NULL, &pwm_clk1, &per1_clk);
+DEFINE_CLOCK(gpt1_clk,     0, NULL,   0, NULL, &gpt1_clk1, &per1_clk);
+DEFINE_CLOCK(gpt2_clk,     1, NULL,   0, NULL, &gpt2_clk1, &per1_clk);
+DEFINE_CLOCK(gpt3_clk,     2, NULL,   0, NULL, &gpt3_clk1, &per1_clk);
+DEFINE_CLOCK(gpt4_clk,     3, NULL,   0, NULL, &gpt4_clk1, &per1_clk);
+DEFINE_CLOCK(gpt5_clk,     4, NULL,   0, NULL, &gpt5_clk1, &per1_clk);
+DEFINE_CLOCK(gpt6_clk,     5, NULL,   0, NULL, &gpt6_clk1, &per1_clk);
+DEFINE_CLOCK(uart1_clk,    0, NULL,   0, NULL, &uart1_clk1, &per1_clk);
+DEFINE_CLOCK(uart2_clk,    1, NULL,   0, NULL, &uart2_clk1, &per1_clk);
+DEFINE_CLOCK(uart3_clk,    2, NULL,   0, NULL, &uart3_clk1, &per1_clk);
+DEFINE_CLOCK(uart4_clk,    3, NULL,   0, NULL, &uart4_clk1, &per1_clk);
+DEFINE_CLOCK(uart5_clk,    4, NULL,   0, NULL, &uart5_clk1, &per1_clk);
+DEFINE_CLOCK(uart6_clk,    5, NULL,   0, NULL, &uart6_clk1, &per1_clk);
+DEFINE_CLOCK1(lcdc_clk,    0, NULL,   0, parent, &lcdc_clk1, &per3_clk);
+DEFINE_CLOCK1(csi_clk,     0, NULL,   0, parent, &csi_clk1, &per4_clk);
 
 #define _REGISTER_CLOCK(d, n, c) \
 	{ \
-- 
1.7.2.3
