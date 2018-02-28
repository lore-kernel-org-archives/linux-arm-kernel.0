From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Wed, 28 Feb 2018 14:11:20 +0100
Subject: [PATCH 1/3] ARM: dts: sun8i: a83t: add cpu0 and cpu100 labels
In-Reply-To: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
References: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
Message-ID: <233019163f0bd877392a64d0c92d3d7c7c717271.1519823347.git-series.quentin.schulz@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A83T is a SoC with two clusters of 4 A7, each cluster
having its own regulator and clock.

The regulators are board-specific, thus we need labels for cpu0 and
cpu100 so that we can use references to these nodes from the board
header file.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 46ae4fa..016d22f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -60,7 +60,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
@@ -84,7 +84,7 @@
 			reg = <3>;
 		};
 
-		cpu at 100 {
+		cpu100: cpu at 100 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x100>;
-- 
git-series 0.9.1
