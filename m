From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:30:32 +0900
Subject: [PATCH v6 13/13] ARM: dts: Use labels for overriding nodes in
 exynos4412-tiny4412
In-Reply-To: <1431851432-413-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
 <1431851432-413-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431851432-413-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts | 54 +++++++++++++++----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index d46fd4c2aeaa..525684ca8dc0 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -56,33 +56,6 @@
 		};
 	};
 
-	rtc at 10070000 {
-		status = "okay";
-	};
-
-	sdhci at 12530000 {
-		bus-width = <4>;
-		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-		pinctrl-names = "default";
-		status = "okay";
-	};
-
-	serial at 13800000 {
-		status = "okay";
-	};
-
-	serial at 13810000 {
-		status = "okay";
-	};
-
-	serial at 13820000 {
-		status = "okay";
-	};
-
-	serial at 13830000 {
-		status = "okay";
-	};
-
 	fixed-rate-clocks {
 		xxti {
 			compatible = "samsung,clock-xxti";
@@ -95,3 +68,30 @@
 		};
 	};
 };
+
+&rtc {
+	status = "okay";
+};
+
+&sdhci_2 {
+	bus-width = <4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&serial_0 {
+	status = "okay";
+};
+
+&serial_1 {
+	status = "okay";
+};
+
+&serial_2 {
+	status = "okay";
+};
+
+&serial_3 {
+	status = "okay";
+};
-- 
2.1.4
