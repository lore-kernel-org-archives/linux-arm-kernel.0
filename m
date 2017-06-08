From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  9 Jun 2017 06:08:40 +0800
Subject: [PATCH v6 7/8] arm64: dts: hikey960: add device node for pmic and
 regulators
In-Reply-To: <20170608220841.26531-1-guodong.xu@linaro.org>
References: <20170608220841.26531-1-guodong.xu@linaro.org>
Message-ID: <20170608220841.26531-8-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>

add device node for hi6421 pmic core and hi6421v530
voltage regulator,include LDO(1,3,9,11,15,16)

Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 46 +++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index ca448f0..e579333 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -97,6 +97,52 @@
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
+			ldo3: LDO3 { /* HDMI */
+				regulator-name = "VOUT3_1V85";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo9: LDO9 { /* SDCARD I/O */
+				regulator-name = "VOUT9_1V8_2V95";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+
+			ldo11: LDO11 { /* Low Speed Connector */
+				regulator-name = "VOUT11_1V8_2V95";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+
+			ldo15: LDO15 { /* UFS VCC */
+				regulator-name = "VOUT15_3V0";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo16: LDO16 { /* SD VDD */
+				regulator-name = "VOUT16_2V95";
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
