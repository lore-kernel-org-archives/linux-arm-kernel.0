From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  1 Jun 2016 21:16:25 +0200
Subject: [PATCH] ARM: BCM5301X: Specify PHY of USB 2.0 in DT
Message-ID: <1464808585-14996-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver for Northstar USB 2.0 PHY was added in 4.7-rc1 by:
commit d3feb4067335 ("phy: bcm-ns-usb2: new driver for USB 2.0 PHY on
Northstar").
It should be used to let EHCI platform driver init PHY.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 7d4d29b..9300e19 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -140,6 +140,22 @@
 		};
 	};
 
+	phys {
+		compatible = "simple-bus";
+		ranges = <0x00000000 0x18000000 0x00100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		usb2_phy2: usb2-phy {
+			compatible = "brcm,ns-usb2-phy";
+			reg = <0x0000c000 0x1000>;
+			reg-names = "dmu";
+			#phy-cells = <0>;
+			clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
+			clock-names = "phy-ref-clk";
+		};
+	};
+
 	axi at 18000000 {
 		compatible = "brcm,bus-axi";
 		reg = <0x18000000 0x1000>;
@@ -217,6 +233,8 @@
 
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			phys = <&usb2_phy2>;
 		};
 
 		usb3: usb3 at 23000 {
-- 
1.8.4.5
