From: guodong.xu@linaro.org (Guodong Xu)
Date: Sat,  2 Apr 2016 17:29:41 +0800
Subject: [PATCH v2 14/16] arm64: dts: hikey: Add hi655x pmic dts node
In-Reply-To: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459589383-16914-15-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Feng <puck.chen@hisilicon.com>

Add the mfd hi655x dts node and regulator support on
hi6220 platform.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Fei Wang <w.f@huawei.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Reviewed-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 87 ++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 28bc646..a6dffa8 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -6,6 +6,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 
 #include "hi6220.dtsi"
 #include "hikey-gpio.dtsi"
@@ -104,6 +105,92 @@
 			default-state = "off";
 		};
 	};
+
+	pmic: pmic at f8000000 {
+		compatible = "hisilicon,hi655x-pmic";
+		reg = <0x0 0xf8000000 0x0 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pmic-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+
+		regulators {
+			ldo2: LDO2 at a21 {
+				regulator-name = "LDO2_2V8";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3200000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo7: LDO7 at a26 {
+				regulator-name = "LDO7_SDIO";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo10: LDO10 at a29 {
+				regulator-name = "LDO10_2V85";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <360>;
+			};
+
+			ldo13: LDO13 at a32 {
+				regulator-name = "LDO13_1V8";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo14: LDO14 at a33 {
+				regulator-name = "LDO14_2V8";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3200000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo15: LDO15 at a34 {
+				regulator-name = "LDO15_1V8";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo17: LDO17 at a36 {
+				regulator-name = "LDO17_2V5";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3200000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo19: LDO19 at a38 {
+				regulator-name = "LDO19_3V0";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <360>;
+			};
+
+			ldo21: LDO21 at a40 {
+				regulator-name = "LDO21_1V8";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo22: LDO22 at a41 {
+				regulator-name = "LDO22_1V2";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-enable-ramp-delay = <120>;
+			};
+		};
+	};
 };
 
 &uart2 {
-- 
1.9.1
