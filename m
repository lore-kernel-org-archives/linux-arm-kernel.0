From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Jan 2013 10:48:53 +0100
Subject: [PATCH 6/9] ARM: at91/dts: add macb mii pinctrl config for kizbox
In-Reply-To: <cover.1358934163.git.nicolas.ferre@atmel.com>
References: <cover.1358934163.git.nicolas.ferre@atmel.com>
Message-ID: <b45c998ea79224b5f8ac718d9be55cacd17fab18.1358934163.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <linux-arm@overkiz.com>

This patch overrides default macb pinctrl config defined in
at91sam9260.dtsi (pinctrl_macb_rmii) with kizbox board config
(pinctrl_macb_rmii + pinctrl_macb_rmii_mii_alt).

Signed-off-by: Boris BREZILLON <linux-arm@overkiz.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/kizbox.dts | 2 ++
 1 file changed, 2 insertions(+)

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
1.8.0
