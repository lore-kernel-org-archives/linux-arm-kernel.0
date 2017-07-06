From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu,  6 Jul 2017 22:28:21 +0800
Subject: [PATCH 1/2] pinctrl: sunxi: add a missing function of A10/A20 pinctrl
 driver
In-Reply-To: <20170706142822.20296-1-icenowy@aosc.io>
References: <20170706142822.20296-1-icenowy@aosc.io>
Message-ID: <20170706142822.20296-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PH16 pin has a function with mux id 0x5, which is the DET pin of the
"sim" (smart card reader) IP block.

This function is missing both in the old A10 and A20 drivers, so it's
not found during the merge of these two drivers.

Add it to the driver. As we now merged A20 pinctrl driver to the A10
one, we need to only fix the A10 driver now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 159580c04b14..47a392bc73c8 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -918,6 +918,7 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION_VARIANT(0x3, "emac",	/* ETXD1 */
 					 PINCTRL_SUN7I_A20),
 		  SUNXI_FUNCTION(0x4, "keypad"),	/* IN6 */
+		  SUNXI_FUNCTION(0x5, "sim"),		/* DET */
 		  SUNXI_FUNCTION_IRQ(0x6, 16),		/* EINT16 */
 		  SUNXI_FUNCTION(0x7, "csi1")),		/* D16 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 17),
-- 
2.13.0
