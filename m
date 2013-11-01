From: matt.porter@linaro.org (Matt Porter)
Date: Fri,  1 Nov 2013 15:45:58 -0400
Subject: [PATCH v2 9/9] ARM: dts: add usb udc support to bcm281xx
In-Reply-To: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1383335158-19730-10-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds USB OTG/PHY and clock support to BCM281xx and enables
UDC support on the bcm11351-brt and bcm28155-ap boards.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
---
 arch/arm/boot/dts/bcm11351-brt.dts |  6 ++++++
 arch/arm/boot/dts/bcm11351.dtsi    | 18 ++++++++++++++++++
 arch/arm/boot/dts/bcm28155-ap.dts  |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 9d36eb4..047c635 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -43,5 +43,11 @@
 		status = "okay";
 	};
 
+	usbotg at 3f120000 {
+		status = "okay";
+	};
 
+	usbphy at 3f130000 {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 0755f43..247f9fd 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -284,4 +284,22 @@
 			#clock-cells = <0>;
 		};
 	};
+
+	usbotg: usbotg at 3f120000 {
+		compatible = "snps,dwc2";
+		reg = <0x3f120000 0x10000>;
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usb_otg_ahb_clk>;
+		clock-names = "otg";
+		phys = <&usbphy>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
+	usbphy: usbphy at 3f130000 {
+		compatible = "brcm,kona-usb2-phy";
+		reg = <0x3f130000 0x28>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index bc4e62c..8347d1b 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -62,4 +62,12 @@
 		max-frequency = <48000000>;
 		status = "okay";
 	};
+
+	usbotg at 3f120000 {
+		status = "okay";
+	};
+
+	usbphy at 3f130000 {
+		status = "okay";
+	};
 };
-- 
1.8.4
