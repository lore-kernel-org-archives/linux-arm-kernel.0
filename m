From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu,  1 Dec 2016 15:10:41 +0100
Subject: [PATCH] ARM: dts: da850: enable high speed for mmc
Message-ID: <20161201141041.31386-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmc controller in da850 supports high speed modes
so add cap-sd-highspeed and cap-mmc-highspeed.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index ffc6e1a..0bfb1c0 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -316,6 +316,8 @@
 		mmc0: mmc at 40000 {
 			compatible = "ti,da830-mmc";
 			reg = <0x40000 0x1000>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
 			interrupts = <16>;
 			dmas = <&edma0 16 0>, <&edma0 17 0>;
 			dma-names = "rx", "tx";
@@ -324,6 +326,8 @@
 		mmc1: mmc at 21b000 {
 			compatible = "ti,da830-mmc";
 			reg = <0x21b000 0x1000>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
 			interrupts = <72>;
 			dmas = <&edma1 28 0>, <&edma1 29 0>;
 			dma-names = "rx", "tx";
-- 
2.9.3
