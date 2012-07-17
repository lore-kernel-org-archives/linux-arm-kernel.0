From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 21:17:46 +0000
Subject: [GIT PULL] Samsung DT for v3.6
In-Reply-To: <143401cd639e$474af610$d5e0e230$%kim@samsung.com>
References: <143401cd639e$474af610$d5e0e230$%kim@samsung.com>
Message-ID: <201207172117.48095.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Kukjin Kim wrote:
> Please pull support samsung spi device tree for v3.6 from:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/dt-samsung
> 
> It is for supporting spi dt for exynos4210 and exynos5250, and got the ack
> from Grant Likely for spi driver.
> 
> Note: Since this is including spi driver changes, so it was made based on
> next/devel-dma-ops which touches same file, Samsung spi driver for avoiding
> bad conflicts.
> 
> If any problems, please kindly let me know.

Applied to next/dt branch. I'm not so happy about new dma channel
properties getting added to additional bindings. I guess I should
have complained earlier about these, so I'm keeping the changes
but I've added the patch below to make it clear that they will
have to change after we have agreed with Vinod and Jon on how
they should be represented.

	Arnd

Subject: [PATCH] ARM: EXYNOS: mark the DMA channel binding for SPI as preliminary

Bindings for DMA channels are still under discussion and will
change once this has been resolved. Therefore we mark them
the newly added ones as preliminary. Let's hope nobody starts
relying on them...

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 59bfc4f..a15ffed 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -18,6 +18,9 @@ Required SoC Specific Properties:
 - interrupts: The interrupt number to the cpu. The interrupt specifier format
   depends on the interrupt controller.
 
+[PRELIMINARY: the dma channel allocation will change once there are
+official DMA bindings]
+
 - tx-dma-channel: The dma channel specifier for tx operations. The format of
   the dma specifier depends on the dma controller.
 
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 6904d9d..02891fe 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -168,8 +168,8 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13920000 0x100>;
 		interrupts = <0 66 0>;
-		tx-dma-channel = <&pdma0 7>;
-		rx-dma-channel = <&pdma0 6>;
+		tx-dma-channel = <&pdma0 7>; /* preliminary */
+		rx-dma-channel = <&pdma0 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -178,8 +178,8 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13930000 0x100>;
 		interrupts = <0 67 0>;
-		tx-dma-channel = <&pdma1 7>;
-		rx-dma-channel = <&pdma1 6>;
+		tx-dma-channel = <&pdma1 7>; /* preliminary */
+		rx-dma-channel = <&pdma1 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -188,8 +188,8 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13940000 0x100>;
 		interrupts = <0 68 0>;
-		tx-dma-channel = <&pdma0 9>;
-		rx-dma-channel = <&pdma0 8>;
+		tx-dma-channel = <&pdma0 9>; /* preliminary */
+		rx-dma-channel = <&pdma0 8>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index a3a2eb2..004aaa8 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -156,8 +156,8 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d20000 0x100>;
 		interrupts = <0 66 0>;
-		tx-dma-channel = <&pdma0 5>;
-		rx-dma-channel = <&pdma0 4>;
+		tx-dma-channel = <&pdma0 5>; /* preliminary */
+		rx-dma-channel = <&pdma0 4>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -166,8 +166,8 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d30000 0x100>;
 		interrupts = <0 67 0>;
-		tx-dma-channel = <&pdma1 5>;
-		rx-dma-channel = <&pdma1 4>;
+		tx-dma-channel = <&pdma1 5>; /* preliminary */
+		rx-dma-channel = <&pdma1 4>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -176,8 +176,8 @@
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d40000 0x100>;
 		interrupts = <0 68 0>;
-		tx-dma-channel = <&pdma0 7>;
-		rx-dma-channel = <&pdma0 6>;
+		tx-dma-channel = <&pdma0 7>; /* preliminary */
+		rx-dma-channel = <&pdma0 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
