From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 18 Mar 2016 12:20:56 +0100
Subject: [PATCH] ARM: dts: rockchip: Add mdio node to ethernet node
Message-ID: <1458300056-6174-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So the dwmac device manages to probe again.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Fixes: 88f8b1bb41c6 ("stmmac: Fix 'eth0: No PHY found' regression")
---
 arch/arm/boot/dts/rk3288-rock2-som.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index 1ece66f3e162..4ba7ddecb478 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -101,6 +101,14 @@
 	snps,reset-delays-us = <0 10000 30000>;
 	rx_delay = <0x10>;
 	tx_delay = <0x30>;
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		ethphy1: ethernet-phy at 1 {
+			reg = <1>;
+		};
+	};
 };
 
 &i2c0 {
-- 
2.5.0
