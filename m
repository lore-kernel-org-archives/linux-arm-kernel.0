From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Thu, 13 Dec 2012 15:03:08 +0100
Subject: [PATCH v2] ARM: dts: add macb mii pinctrl config for kizbox
Message-ID: <1355407388-7294-1-git-send-email-linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch overrides default macb pinctrl config defined in 
at91sam9260.dtsi (pinctrl_macb_rmii) with kizbox board config 
(pinctrl_macb_rmii + pinctrl_macb_rmii_mii_alt).

changes since v1 :
	- add missing rmii signals to pinctrl config.

Regards,

Boris

Signed-off-by: Boris BREZILLON <linux-arm@overkiz.com>
---
diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
index e8814fe..b4dc3ed 100644
--- a/arch/arm/boot/dts/kizbox.dts
+++ b/arch/arm/boot/dts/kizbox.dts
@@ -48,6 +48,8 @@
 
 			macb0: ethernet at fffc4000 {
 				phy-mode = "mii";
+				pinctrl-0 = <&pinctrl_macb_rmii
+				             &pinctrl_macb_rmii_mii_alt>;
 				status = "okay";
 			};
 
-- 
1.7.9.5
