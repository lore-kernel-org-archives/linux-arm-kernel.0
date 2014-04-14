From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Apr 2014 17:37:29 +0200
Subject: [PATCH 07/10] ARM: dts: pbab01: Add I2C devices
In-Reply-To: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
References: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1397489852-1669-7-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the TLV320, STMPE811, RTC8564, and MX1037 ICs to the I2C2 bus.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index a449a580..c6ab762 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -28,6 +28,26 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	clock-frequency = <100000>;
 	status = "okay";
+
+	tlv320 at 18 {
+		compatible = "ti,tlv320aic3x";
+		reg = <0x18>;
+	};
+
+	stmpe at 41 {
+		compatible = "st,stmpe811";
+		reg = <0x41>;
+	};
+
+	rtc at 51 {
+		compatible = "nxp,rtc8564";
+		reg = <0x51>;
+	};
+
+	adc at 64 {
+		compatible = "maxim,max1037";
+		reg = <0x64>;
+	};
 };
 
 &i2c3 {
-- 
1.9.1
