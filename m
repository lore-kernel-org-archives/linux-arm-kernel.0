From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 10 Nov 2017 17:26:54 +0800
Subject: [PATCH] arm64: allwinner: a64: add Ethernet PHY regulator for several
 boards
Message-ID: <20171110092654.10746-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On several A64 boards the Ethernet PHY is powered by the DC1SW regulator
on the AXP803 PMIC.

Add phy-handle property to these boards' emac node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts           | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 45bdbfb96126..4a8d3f83a36e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -75,6 +75,7 @@
 	pinctrl-0 = <&rgmii_pins>;
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_dc1sw>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 806442d3e846..604cdaedac38 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -77,6 +77,7 @@
 	pinctrl-0 = <&rmii_pins>;
 	phy-mode = "rmii";
 	phy-handle = <&ext_rmii_phy1>;
+	phy-supply = <&reg_dc1sw>;
 	status = "okay";
 
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 0eb2acedf8c3..a053a6ac5267 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -82,6 +82,7 @@
 	pinctrl-0 = <&rgmii_pins>;
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_dc1sw>;
 	status = "okay";
 };
 
-- 
2.14.2
