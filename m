From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Mar 2016 08:38:09 +0900
Subject: [PATCH v6 20/21] ARM: dts: Expand the voltage range of buck1/3
 regulator for exynos4412-odroidu3
In-Reply-To: <1459121890-4601-1-git-send-email-cw00.choi@samsung.com>
References: <1459121890-4601-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1459121890-4601-21-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch expands the voltage range of buck1/3 regulator due to as following:
- MIF (Memory Interface) bus frequency needs the range of '900 - 1100 mV'.
- INT (Internal) bus frequency needs the range of '900 - 1050 mV'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
[m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index cba37c974703..b4983cbc4f8c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -356,8 +356,8 @@
 
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
@@ -372,8 +372,8 @@
 
 			buck3_reg: BUCK3 {
 				regulator-name = "vdd_int";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
-- 
1.9.1
