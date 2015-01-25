From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 25 Jan 2015 20:22:07 +0800
Subject: [PATCH v2 6/9] ARM: dts: sunxi: Add usb3_vbus regulator to common
 regulators dtsi
In-Reply-To: <1422188530-1794-1-git-send-email-wens@csie.org>
References: <1422188530-1794-1-git-send-email-wens@csie.org>
Message-ID: <1422188530-1794-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs have a total of 4 possible USB controllers. One such example
is the A80, which has one USB3 dual role device and 3 EHCI/OHCI pairs.

Add a common VBUS regulator for the last host controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index e02baa66b33c..97fe8d73c4f7 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -130,6 +130,16 @@
 		status = "disabled";
 	};
 
+	reg_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		status = "disabled";
+	};
+
 	reg_vcc3v0: vcc3v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v0";
-- 
2.1.4
