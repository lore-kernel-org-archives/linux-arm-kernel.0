From: matt.porter@linaro.org (Matt Porter)
Date: Mon,  7 Oct 2013 06:12:32 -0400
Subject: [PATCH 5/5] ARM: dts: add usb udc support to bcm281xx
In-Reply-To: <1381140752-312-1-git-send-email-matt.porter@linaro.org>
References: <1381140752-312-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1381140752-312-6-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds USB OTG/Control/PHY and clock support to BCM281xx and enables
UDC support on the bcm11351-brt and bcm28155-ap boards.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
---
 arch/arm/boot/dts/bcm11351-brt.dts | 10 ++++++++++
 arch/arm/boot/dts/bcm11351.dtsi    | 21 +++++++++++++++++++++
 arch/arm/boot/dts/bcm28155-ap.dts  | 12 ++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 9d36eb4..5a269c7 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -43,5 +43,15 @@
 		status = "okay";
 	};
 
+	usbotg at 3f120000 {
+		status = "okay";
+	};
 
+	usbctl at 3f130000 {
+		status = "okay";
+	};
+
+	usbphy {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 22aef21..1c647f2 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -227,4 +227,25 @@
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
+		snps,phy-utmi-width = <8>;
+		status = "disabled";
+	};
+
+	usbctl: usbctl at 3f130000 {
+		compatible = "brcm,kona-ctrl-usb";
+		reg = <0x3f130000 0x28>;
+		status = "disabled";
+	};
+
+	usbphy: usbphy {
+		compatible = "brcm,kona-usb2";
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 96ae67a..7b1b741 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -42,4 +42,16 @@
 		max-frequency = <48000000>;
 		status = "okay";
 	};
+
+	usbotg at 3f120000 {
+		status = "okay";
+	};
+
+	usbctl at 3f130000 {
+		status = "okay";
+	};
+
+	usbphy {
+		status = "okay";
+	};
 };
-- 
1.8.4
