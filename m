From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Tue, 19 May 2015 20:52:51 +0900
Subject: [RESEND PATCH 2/2] ARM: dts: s3c2416: Use labels for overriding nodes
 in SMDK2416
In-Reply-To: <1432036371-6407-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1432036371-6407-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1432036371-6407-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/s3c2416-smdk2416.dts | 86 +++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index ea92fd69529a..f257926c13b7 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -31,55 +31,55 @@
 			#clock-cells = <0>;
 		};
 	};
+};
 
-	serial at 50000000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart0_data>, <&uart0_fctl>;
-	};
+&rtc {
+	status = "okay";
+};
 
-	serial at 50004000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart1_data>, <&uart1_fctl>;
-	};
+&sdhci_0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd1_clk>, <&sd1_cmd>,
+			<&sd1_bus1>, <&sd1_bus4>;
+	bus-width = <4>;
+	broken-cd;
+	status = "okay";
+};
 
-	serial at 50008000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart2_data>;
-	};
+&sdhci_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>,
+			<&sd0_bus1>, <&sd0_bus4>;
+	bus-width = <4>;
+	cd-gpios = <&gpf 1 0>;
+	cd-inverted;
+	status = "okay";
+};
 
-	serial at 5000C000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart3_data>;
-	};
+&uart_0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_data>, <&uart0_fctl>;
+};
 
-	watchdog at 53000000 {
-		status = "okay";
-	};
+&uart_1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_data>, <&uart1_fctl>;
+};
 
-	rtc at 57000000 {
-		status = "okay";
-	};
+&uart_2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_data>;
+};
 
-	sdhci at 4AC00000 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd0_clk>, <&sd0_cmd>,
-				<&sd0_bus1>, <&sd0_bus4>;
-		bus-width = <4>;
-		cd-gpios = <&gpf 1 0>;
-		cd-inverted;
-		status = "okay";
-	};
+&uart_3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_data>;
+};
 
-	sdhci at 4A800000 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd1_clk>, <&sd1_cmd>,
-				<&sd1_bus1>, <&sd1_bus4>;
-		bus-width = <4>;
-		broken-cd;
-		status = "okay";
-	};
+&watchdog {
+	status = "okay";
 };
-- 
2.1.4
