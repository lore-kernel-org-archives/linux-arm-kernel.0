From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon,  8 May 2017 18:21:15 +0200
Subject: [PATCH 6/8] arm64: dts: hikey: Add the SYS_5V and the VDD_3V3
 regulators
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1494260477-25163-7-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add these regulators to better describe the HW, but also because those is
needed in following changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 8070c75..6dab03a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -81,7 +81,26 @@
 		};
 	};
 
-	reg_5v_hub: regulator at 0 {
+	reg_sys_5v: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "SYS_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_vdd_3v3: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&reg_sys_5v>;
+	};
+
+	reg_5v_hub: regulator at 2 {
 		compatible = "regulator-fixed";
 		regulator-name = "5V_HUB";
 		regulator-min-microvolt = <5000000>;
@@ -89,6 +108,7 @@
 		regulator-boot-on;
 		gpio = <&gpio0 7 0>;
 		regulator-always-on;
+		vin-supply = <&reg_sys_5v>;
 	};
 
 	soc {
-- 
2.7.4
