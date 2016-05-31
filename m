From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 20:39:02 +0200
Subject: [PATCH 3/6] ARM: dts: exynos: Interrupt for USB DWC3-1 differs
 between Exynos5420 and 5410
In-Reply-To: <1464719945-3417-1-git-send-email-krzk@kernel.org>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
Message-ID: <1464719945-3417-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos5410 the SPI interrupt for second USB DWC3 (called DRD: Dual
Role Device) is different - 200 instead of 73.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 4 ++++
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++++
 arch/arm/boot/dts/exynos54xx.dtsi | 1 -
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index a937d9bdad90..994d16a44fe4 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -267,6 +267,10 @@
 	clock-names = "usbdrd30";
 };
 
+&usbdrd_dwc3_1 {
+	interrupts = <0 200 0>;
+};
+
 &usbdrd_phy1 {
 	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
 	clock-names = "phy", "ref";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8b1e706e9250..265747bb19d1 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1046,6 +1046,10 @@
 	clock-names = "usbdrd30";
 };
 
+&usbdrd_dwc3_1 {
+	interrupts = <0 73 0>;
+};
+
 &usbdrd_phy1 {
 	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
 	clock-names = "phy", "ref";
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 44a8391c8524..0eb8aa31b7d9 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -141,7 +141,6 @@
 			usbdrd_dwc3_1: dwc3 at 12400000 {
 				compatible = "snps,dwc3";
 				reg = <0x12400000 0x10000>;
-				interrupts = <0 73 0>;
 				phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
-- 
2.7.4
