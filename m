From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:55 +0900
Subject: [PATCH 124/130] pinctrl: sh-pfc: r8a7779: Fix missing MOD_SEL2 entry
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-125-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The list of functions selected by the MOD_SEL2 register was missing
an entry. This caused all entries after this to modify the MOD_SEL2
register incorrectly.

This bug showed up when selecting i2c2_c pins on the Renesas Hurricane board.

This bug has been present since pinmux support was added for the
r8a7779 SoC by 881023d28b465eb457067dc8bbca0f24d8b34279 ("sh-pfc: Add
r8a7779 pinmux support") in v3.8-rc4.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 96bdf48..8e22ca6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -3768,7 +3768,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* SEL_SCIF [2] */
 	    FN_SEL_SCIF_0, FN_SEL_SCIF_1, FN_SEL_SCIF_2, FN_SEL_SCIF_3,
 	    /* SEL_CANCLK [2] */
-	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2,
+	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2, 0,
 	    /* SEL_CAN0 [1] */
 	    FN_SEL_CAN0_0, FN_SEL_CAN0_1,
 	    /* SEL_HSCIF1 [1] */
-- 
1.8.2.1
