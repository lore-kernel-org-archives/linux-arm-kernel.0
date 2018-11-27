From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:15 +0100
Subject: [PATCH 14/77] ARM: dts: sunxi: Change default CMA pool node name
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <1a8583339afbc1e7e3590e5ca134eae2f7284f4f.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CMA node has a unit address, but no reg property which generates a
warning in DTC. Change the node name to reflect its usage and drop the unit
address.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/media/cedrus.txt | 2 +-
 arch/arm/boot/dts/sun5i.dtsi                       | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 2 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/cedrus.txt b/Documentation/devicetree/bindings/media/cedrus.txt
index a089a0c1ff05..33833a43fff8 100644
--- a/Documentation/devicetree/bindings/media/cedrus.txt
+++ b/Documentation/devicetree/bindings/media/cedrus.txt
@@ -31,7 +31,7 @@ reserved-memory {
 	ranges;
 
 	/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
-	cma_pool: cma at 4a000000 {
+	cma_pool: default-pool {
 		compatible = "shared-dma-pool";
 		size = <0x6000000>;
 		alloc-ranges = <0x4a000000 0x6000000>;
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index acf143317540..307c6790b227 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -114,7 +114,7 @@
 		ranges;
 
 		/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
-		cma_pool: cma at 4a000000 {
+		cma_pool: default-pool {
 			compatible = "shared-dma-pool";
 			size = <0x6000000>;
 			alloc-ranges = <0x4a000000 0x6000000>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index b4fd4f5ca66b..f7dcf8d21fd2 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -181,7 +181,7 @@
 		ranges;
 
 		/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
-		cma_pool: cma at 4a000000 {
+		cma_pool: default-pool {
 			compatible = "shared-dma-pool";
 			size = <0x6000000>;
 			alloc-ranges = <0x4a000000 0x6000000>;
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 502de6f44a9a..a8b2c4d14f99 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -196,7 +196,7 @@
 		ranges;
 
 		/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
-		cma_pool: cma at 4a000000 {
+		cma_pool: default-pool {
 			compatible = "shared-dma-pool";
 			size = <0x6000000>;
 			alloc-ranges = <0x4a000000 0x6000000>;
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 3ecfabb10151..b3921c5171ed 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -124,7 +124,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		cma_pool: cma at 4a000000 {
+		cma_pool: default-pool {
 			compatible = "shared-dma-pool";
 			size = <0x6000000>;
 			alloc-ranges = <0x4a000000 0x6000000>;
-- 
git-series 0.9.1
