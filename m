From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:26:08 +0900
Subject: [PATCH v4 1/8] ARM: dts: Add labels to exynos5 nodes
In-Reply-To: <1431851175-32624-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431851175-32624-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431851175-32624-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new labels to certain nodes so they could be easily referenced by
Exynos5 board DTS files.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos5.dtsi    | 6 +++---
 arch/arm/boot/dts/exynos5440.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index a0cc0b6f8f96..110dbd4fb884 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -81,14 +81,14 @@
 		interrupts = <0 54 0>;
 	};
 
-	rtc at 101E0000 {
+	rtc: rtc at 101E0000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x101E0000 0x100>;
 		interrupts = <0 43 0>, <0 44 0>;
 		status = "disabled";
 	};
 
-	fimd at 14400000 {
+	fimd: fimd at 14400000 {
 		compatible = "samsung,exynos5250-fimd";
 		interrupt-parent = <&combiner>;
 		reg = <0x14400000 0x40000>;
@@ -98,7 +98,7 @@
 		status = "disabled";
 	};
 
-	dp-controller at 145B0000 {
+	dp: dp-controller at 145B0000 {
 		compatible = "samsung,exynos5-dp";
 		reg = <0x145B0000 0x1000>;
 		interrupts = <10 3>;
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 59d9416b3b03..f18b51f2eeaa 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -279,7 +279,7 @@
 		clock-names = "usbhost";
 	};
 
-	pcie at 290000 {
+	pcie_0: pcie at 290000 {
 		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
 		reg = <0x290000 0x1000
 			0x270000 0x1000
@@ -300,7 +300,7 @@
 		status = "disabled";
 	};
 
-	pcie at 2a0000 {
+	pcie_1: pcie@2a0000 {
 		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
 		reg = <0x2a0000 0x1000
 			0x272000 0x1000
-- 
2.1.4
