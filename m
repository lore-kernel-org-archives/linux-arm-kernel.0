From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 28 Jul 2017 11:28:17 +0200
Subject: [PATCH 2/3] ARM: sunxi: h3/h5: Add sun8i-h3-ephy compatible
In-Reply-To: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
Message-ID: <20170728092818.23419-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the sun8i-h3-ephy compatible to the internal PHY.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 4b599b5d26f6..7aaa837c2388 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -421,7 +421,8 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				int_mii_phy: ethernet-phy at 1 {
-					compatible = "ethernet-phy-ieee802.3-c22";
+					compatible = "allwinner,sun8i-h3-ephy",
+							"ethernet-phy-ieee802.3-c22";
 					reg = <1>;
 					clocks = <&ccu CLK_BUS_EPHY>;
 					resets = <&ccu RST_BUS_EPHY>;
-- 
2.13.0
