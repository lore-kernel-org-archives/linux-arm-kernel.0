From: embed3d@gmail.com (Philipp Rossak)
Date: Sun, 17 Dec 2017 23:45:47 +0100
Subject: [PATCH 5/5] arm: dts: sun8i: a83t: bananapi-m3: Enable IR controller
In-Reply-To: <20171217224547.21481-1-embed3d@gmail.com>
References: <20171217224547.21481-1-embed3d@gmail.com>
Message-ID: <20171217224547.21481-6-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Bananapi M3 has an onboard IR receiver.
This enables the onboard IR receiver subnode.
Other than the other IR receivers this one needs a base clock frequency
of 3000000 Hz (3 MHz), to be able to work.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 6550bf0e594b..2bf25ca64133 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -100,6 +100,13 @@
 	status = "okay";
 };
 
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	clock-frequency = <3000000>;
+	status = "okay";
+};
+
 &mdio {
 	rgmii_phy: ethernet-phy at 1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.11.0
