From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 30 Aug 2018 16:09:24 +0800
Subject: [PATCH 1/3] ARM: dts: sun8i: h3: bpi-m2-plus: Fix address for
 external RGMII Ethernet PHY
In-Reply-To: <20180830080926.15027-1-wens@csie.org>
References: <20180830080926.15027-1-wens@csie.org>
Message-ID: <20180830080926.15027-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The external RTL8211E RGMII Ethernet PHY is configured via external
resistors to use the address 0x1. The 0x0 address is a broadcast address
for this family of PHYs, and should not be used explicitly.

Fixes: 8c7ba536e709 ("ARM: sun8i: bananapi-m2-plus: Enable dwmac-sun8i")
Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 30540dc8e0c5..bdda0d99128e 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -140,7 +140,7 @@
 &external_mdio {
 	ext_rgmii_phy: ethernet-phy at 1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
+		reg = <1>;
 	};
 };
 
-- 
2.18.0
