From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 08 Jul 2017 20:16:50 +0100
Subject: [PATCH 5/6] arm64: dts: marvell: mcbin: add support for i2c mux
In-Reply-To: <20170708191317.GM4902@n2100.armlinux.org.uk>
References: <20170708191317.GM4902@n2100.armlinux.org.uk>
Message-ID: <E1dTvDm-0007F4-28@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MACCHIATOBin board has a PCA9548 I2C mux for the SFP ports on
CP100 master I2C bus 1.  Add the DT description for it.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index b20c17160cbb..1372558d037b 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -121,6 +121,36 @@
 	status = "okay";
 };
 
+&cpm_i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpm_i2c1_pins>;
+	status = "okay";
+
+	i2c-switch at 70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		sfpp0_i2c: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		sfpp1_i2c: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		sfp_1g_i2c: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+	};
+};
+
 &cpm_mdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cpm_ge_mdio_pins>;
@@ -136,6 +166,10 @@
 		marvell,pins = "mpp32", "mpp34";
 		marvell,function = "ge";
 	};
+	cpm_i2c1_pins: i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
 	cpm_i2c0_pins: i2c0-pins {
 		marvell,pins = "mpp37", "mpp38";
 		marvell,function = "i2c0";
-- 
2.7.4
