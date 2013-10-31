From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 31 Oct 2013 12:18:44 +0530
Subject: [PATCH 4/4] ARM: dts: Add S5M8767 clock nodes on Arndale board
In-Reply-To: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1383202124-1775-5-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index b77a37e..34b305d 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -70,6 +70,13 @@
 			s5m8767,pmic-buck-ds-gpios = <&gpx2 3 0>,
 							<&gpx2 4 0>,
 							<&gpx2 5 0>;
+
+			s5m8767_osc: clocks {
+				#clock-cells = <1>;
+				clock-output-names = "s5m8767_ap",
+						"s5m8767_cp", "s5m8767_bt";
+			};
+
 			regulators {
 				ldo1_reg: LDO1 {
 					regulator-name = "VDD_ALIVE_1.0V";
-- 
1.7.9.5
