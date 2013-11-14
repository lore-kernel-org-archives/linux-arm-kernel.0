From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 14 Nov 2013 11:10:39 -0800
Subject: [PATCH v3 4/8] ARM: dts: Specify clocks for SDHCIs on bcm11351
In-Reply-To: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
References: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1384456243-27053-5-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the external clock label in each SDHCI node.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 9b99c52..cfa1158 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -117,6 +117,7 @@
 	sdio1: sdio at 3f180000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
+		clocks = <&sdio1_clk>;
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -124,6 +125,7 @@
 	sdio2: sdio at 3f190000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f190000 0x10000>;
+		clocks = <&sdio2_clk>;
 		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -131,6 +133,7 @@
 	sdio3: sdio at 3f1a0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1a0000 0x10000>;
+		clocks = <&sdio3_clk>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -138,6 +141,7 @@
 	sdio4: sdio at 3f1b0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
+		clocks = <&sdio4_clk>;
 		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
-- 
1.8.0.1
