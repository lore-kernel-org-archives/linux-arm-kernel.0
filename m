From: embed3d@gmail.com (Philipp Rossak)
Date: Fri, 15 Dec 2017 23:39:01 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Nanopi M1
In-Reply-To: <20171215223901.14500-1-embed3d@gmail.com>
References: <20171215223901.14500-1-embed3d@gmail.com>
Message-ID: <20171215223901.14500-3-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the Nanopi M1.
It uses the internal PHY

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
index 3a2ccdb28afd..c77fbca4f227 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
@@ -45,6 +45,10 @@
 / {
 	model = "FriendlyArm NanoPi M1";
 	compatible = "friendlyarm,nanopi-m1", "allwinner,sun8i-h3";
+
+	aliases {
+		ethernet0 = &emac;
+	};
 };
 
 &ehci1 {
@@ -55,6 +59,13 @@
 	status = "okay";
 };
 
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.11.0
