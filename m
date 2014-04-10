From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:10 +0900
Subject: [PATCH 20/27] ARM: dts: exynos3250: Move definitions of external
 clocks to SoC dtsi
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-12-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <t.figa@samsung.com>

This allows proper ordering of clock registration and is still correct,
because list of external clocks is SoC-specific, just their frequencies
and availability are board-specific.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Hyunhee Kim <hyunhee.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 587a124..ceed761 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -40,6 +40,36 @@
 		i2c7 = &i2c_7;
 	};
 
+	fixed-rate-clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		xusbxti: clock at 0 {
+			compatible = "fixed-clock";
+			reg = <0>;
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "xusbxti";
+		};
+
+		xxti: clock at 1 {
+			compatible = "fixed-clock";
+			reg = <1>;
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "xxti";
+		};
+
+		xtcxo: clock at 2 {
+			compatible = "fixed-clock";
+			reg = <2>;
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "xtcxo";
+		};
+	};
+
 	chipid at 10000000 {
 		compatible = "samsung,exynos4210-chipid";
 		reg = <0x10000000 0x100>;
-- 
1.8.0
