From: matt.porter@linaro.org (Matt Porter)
Date: Thu, 19 Sep 2013 13:18:26 -0400
Subject: [PATCH] ARM: dts: bcm11351: Use GIC/IRQ defines for sdio interrupts
Message-ID: <1379611106-18338-1-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial patch to make use of GIC/IRQ defines on the bcm11351 sdio
interrupt properties.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 05a5aab..5fc64ab 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -71,28 +71,28 @@
 	sdio1: sdio at 3f180000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
-		interrupts = <0x0 77 0x4>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
 	sdio2: sdio at 3f190000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f190000 0x10000>;
-		interrupts = <0x0 76 0x4>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
 	sdio3: sdio at 3f1a0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1a0000 0x10000>;
-		interrupts = <0x0 74 0x4>;
+		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
 	sdio4: sdio at 3f1b0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
-		interrupts = <0x0 73 0x4>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
-- 
1.8.4
