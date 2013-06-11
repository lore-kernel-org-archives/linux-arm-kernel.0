From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Jun 2013 17:02:19 +0900
Subject: [PATCH] ARM: dts: Removing pdma for SSDK5440
Message-ID: <109601ce6679$fef2e410$fcd8ac30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Giridhar Maruthy <giridhar.m@samsung.com>

Since the pdma works only in secure mode, accessing the same
in hypervisor mode gives an abort. As we are not using pdma
anywhere (including spi), removing the same.

Signed-off-by: Giridhar Maruthy <giridhar.m@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 871ebad..b08449e 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -105,8 +105,6 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0xD0000 0x1000>;
 		interrupts = <0 4 0>;
-		tx-dma-channel = <&pdma0 5>; /* preliminary */
-		rx-dma-channel = <&pdma0 4>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&clock 21>, <&clock 16>;
@@ -184,28 +182,6 @@
 		compatible = "arm,amba-bus";
 		interrupt-parent = <&gic>;
 		ranges;
-
-		pdma0: pdma at 00121000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121000 0x1000>;
-			interrupts = <0 46 0>;
-			clocks = <&clock 8>;
-			clock-names = "apb_pclk";
-			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
-		};
-
-		pdma1: pdma at 00120000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x120000 0x1000>;
-			interrupts = <0 47 0>;
-			clocks = <&clock 8>;
-			clock-names = "apb_pclk";
-			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
-		};
 	};
 
 	rtc {
-- 
1.7.10.4
