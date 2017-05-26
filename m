From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 26 May 2017 14:35:17 +0800
Subject: [PATCH 5/6] arm64: dts: hikey960: add device node for pmic and
 regulators
In-Reply-To: <20170526063518.21246-1-guodong.xu@linaro.org>
References: <20170526063518.21246-1-guodong.xu@linaro.org>
Message-ID: <20170526063518.21246-6-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>

add device node for hi6421 pmic core and hi6421v530
voltage regulator,include LDO(1,3,9,11,15,16)

Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 60 +++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index ca448f0..b7a404a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -97,6 +97,66 @@
 			default-state = "off";
 		};
 	};
+
+	pmic: pmic at fff34000 {
+		compatible = "hisilicon,hi6421v530-pmic";
+		reg = <0x0 0xfff34000 0x0 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		regulators {
+			ldo1: LDO1 {
+				regulator-compatible = "hi6421v530_ldo1";
+					regulator-name = "LDO1";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1500000>;
+					regulator-always-on;
+					regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo3: LDO3 {
+				regulator-compatible = "hi6421v530_ldo3";
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-always-on;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo9: LDO9 {
+				regulator-compatible = "hi6421v530_ldo9";
+				regulator-name = "LDO9";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+
+			ldo11: LDO11 {
+				regulator-compatible = "hi6421v530_ldo11";
+				regulator-name = "LDO11";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+
+			ldo15: LDO15 {
+				regulator-compatible = "hi6421v530_ldo15";
+				regulator-name = "LDO15";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo16: LDO16 {
+				regulator-compatible = "hi6421v530_ldo16";
+				regulator-name = "LDO16";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <360>;
+			};
+		};
+	};
 };
 
 &i2c0 {
-- 
2.10.2
