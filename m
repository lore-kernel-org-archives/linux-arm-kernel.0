From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 09 Feb 2015 13:41:35 +0100
Subject: [PATCH] ARM: dts: exynos5420: Add maudio power domain
Message-ID: <1423485695-22568-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maudio power domain to Exynos 5420 DTSI file so its state could be
tracked. This actually won't power down this domain because the pl330
dmaengine driver (for adma channel) uses IRQ safe runtime PM. Thus the
patch should not introduce any functional change except of visibility of
this domain to the system.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 6d38f8bfd0e6..2e99a39f7250 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -270,6 +270,11 @@
 		reg = <0x10044120 0x20>;
 	};
 
+	mau_pd: power-domain at 100440E0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440E0 0x20>;
+	};
+
 	pinctrl_0: pinctrl at 13400000 {
 		compatible = "samsung,exynos5420-pinctrl";
 		reg = <0x13400000 0x1000>;
@@ -328,6 +333,7 @@
 			#dma-cells = <1>;
 			#dma-channels = <6>;
 			#dma-requests = <16>;
+			samsung,power-domain = <&mau_pd>;
 		};
 
 		pdma0: pdma at 121A0000 {
@@ -397,6 +403,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
 		status = "disabled";
+		samsung,power-domain = <&mau_pd>;
 	};
 
 	i2s1: i2s at 12D60000 {
-- 
1.9.1
