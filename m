From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 23 Feb 2018 18:16:30 +0800
Subject: [PATCH v1 10/19] arm: dts: mt7623: remove useless property
 pinctrl-names at node switch@0
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
Message-ID: <9c8c23657d9812e24c6f07b7477a6ac0ebdd1c68.1519378872.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The property pinctrl-names is totally superfluous. It would be good to
remove the property to keep the node neatness. There is actually
unnecessary to set up any pins for data path TRGMII between main SoC and
MT7530. Furthermore, it's more reasonable for the pin setup of control
path MDIO bus is being placed inside the node of ethernet controller.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 6b760be..f2d3cfb 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -151,7 +151,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-			pinctrl-names = "default";
 			reset-gpios = <&pio 33 0>;
 			core-supply = <&mt6323_vpa_reg>;
 			io-supply = <&mt6323_vemc3v3_reg>;
-- 
2.7.4
