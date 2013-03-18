From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:51 +0900
Subject: [PATCH 115/142] sh-pfc: r8a7740: Remove SDHI and MMCIF function GPIOS
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-116-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All r8a7740 platforms now use the pinctrl API to control the SDHI and
MMCIF pins, the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |   35 ----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index de1212d..3621d3e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2373,26 +2373,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(SIM_D_PORT22), /* SIM_D  Port 22/199 */
 	GPIO_FN(SIM_D_PORT199),
 
-	/* SDHI0 */
-	GPIO_FN(SDHI0_D0),	GPIO_FN(SDHI0_D1),	GPIO_FN(SDHI0_D2),
-	GPIO_FN(SDHI0_D3),	GPIO_FN(SDHI0_CD),	GPIO_FN(SDHI0_WP),
-	GPIO_FN(SDHI0_CMD),	GPIO_FN(SDHI0_CLK),
-
-	/* SDHI1 */
-	GPIO_FN(SDHI1_D0),	GPIO_FN(SDHI1_D1),	GPIO_FN(SDHI1_D2),
-	GPIO_FN(SDHI1_D3),	GPIO_FN(SDHI1_CD),	GPIO_FN(SDHI1_WP),
-	GPIO_FN(SDHI1_CMD),	GPIO_FN(SDHI1_CLK),
-
-	/* SDHI2 */
-	GPIO_FN(SDHI2_D0),	GPIO_FN(SDHI2_D1),	GPIO_FN(SDHI2_D2),
-	GPIO_FN(SDHI2_D3),	GPIO_FN(SDHI2_CLK),	GPIO_FN(SDHI2_CMD),
-
-	GPIO_FN(SDHI2_CD_PORT24), /* MSEL5CR_19_0 */
-	GPIO_FN(SDHI2_WP_PORT25),
-
-	GPIO_FN(SDHI2_WP_PORT177), /* MSEL5CR_19_1 */
-	GPIO_FN(SDHI2_CD_PORT202),
-
 	/* MSIOF2 */
 	GPIO_FN(MSIOF2_TXD),	GPIO_FN(MSIOF2_RXD),	GPIO_FN(MSIOF2_TSCK),
 	GPIO_FN(MSIOF2_SS2),	GPIO_FN(MSIOF2_TSYNC),	GPIO_FN(MSIOF2_SS1),
@@ -2437,21 +2417,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MEMC_WAIT),	GPIO_FN(MEMC_DREQ1),	GPIO_FN(MEMC_BUSCLK),
 	GPIO_FN(MEMC_A0),
 
-	/* MMC */
-	GPIO_FN(MMC0_D0_PORT68),	GPIO_FN(MMC0_D1_PORT69),
-	GPIO_FN(MMC0_D2_PORT70),	GPIO_FN(MMC0_D3_PORT71),
-	GPIO_FN(MMC0_D4_PORT72),	GPIO_FN(MMC0_D5_PORT73),
-	GPIO_FN(MMC0_D6_PORT74),	GPIO_FN(MMC0_D7_PORT75),
-	GPIO_FN(MMC0_CLK_PORT66),
-	GPIO_FN(MMC0_CMD_PORT67),	/* MSEL4CR_15_0 */
-
-	GPIO_FN(MMC1_D0_PORT149),	GPIO_FN(MMC1_D1_PORT148),
-	GPIO_FN(MMC1_D2_PORT147),	GPIO_FN(MMC1_D3_PORT146),
-	GPIO_FN(MMC1_D4_PORT145),	GPIO_FN(MMC1_D5_PORT144),
-	GPIO_FN(MMC1_D6_PORT143),	GPIO_FN(MMC1_D7_PORT142),
-	GPIO_FN(MMC1_CLK_PORT103),
-	GPIO_FN(MMC1_CMD_PORT104),	/* MSEL4CR_15_1 */
-
 	/* MSIOF0 */
 	GPIO_FN(MSIOF0_SS1),	GPIO_FN(MSIOF0_SS2),	GPIO_FN(MSIOF0_RXD),
 	GPIO_FN(MSIOF0_TXD),	GPIO_FN(MSIOF0_MCK0),	GPIO_FN(MSIOF0_MCK1),
-- 
1.7.10.4
