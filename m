From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon,  8 May 2017 18:21:14 +0200
Subject: [PATCH 5/8] arm64: dts: hi6220: Move the fixed_5v_hub regulator to
 the hikey dts
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1494260477-25163-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator is a part of the hikey board, therefore let's move it from
the hi6220 SoC dtsi file into the hikey dts file . Let's also rename the
regulator according to the datasheet (5V_HUB) to better reflect the HW.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 10 ++++++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 12 +-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e0496f7..8070c75 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -81,6 +81,16 @@
 		};
 	};
 
+	reg_5v_hub: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_HUB";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		gpio = <&gpio0 7 0>;
+		regulator-always-on;
+	};
+
 	soc {
 		spi0: spi at f7106000 {
 			status = "ok";
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 1e5129b..951152d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -725,20 +725,10 @@
 			status = "disabled";
 		};
 
-		fixed_5v_hub: regulator at 0 {
-			compatible = "regulator-fixed";
-			regulator-name = "fixed_5v_hub";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-boot-on;
-			gpio = <&gpio0 7 0>;
-			regulator-always-on;
-		};
-
 		usb_phy: usbphy {
 			compatible = "hisilicon,hi6220-usb-phy";
 			#phy-cells = <0>;
-			phy-supply = <&fixed_5v_hub>;
+			phy-supply = <&reg_5v_hub>;
 			hisilicon,peripheral-syscon = <&sys_ctrl>;
 		};
 
-- 
2.7.4
