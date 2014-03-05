From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  5 Mar 2014 11:35:34 +0800
Subject: [PATCH 1/2] ARM: dts: sirf: move to use generic dma dt-binding for spi
Message-ID: <1393990536-9306-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This patch is following commit dd7243d6a5d in spi-next tree.in drivers/spi/
spi-sirf.c, we have moved to use generic dma dt-binding. here the dts should
be changed too.

Cc: Mark Brown <broonie@linaro.org>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |   11 ++++++-----
 arch/arm/boot/dts/prima2.dtsi |   10 ++++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 5d7879b..14495c4 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -293,9 +293,9 @@
 				reg = <0xb00d0000 0x10000>;
 				interrupts = <15>;
 				sirf,spi-num-chipselects = <1>;
-				cs-gpios = <&gpio 0 0>;
-				sirf,spi-dma-rx-channel = <25>;
-				sirf,spi-dma-tx-channel = <20>;
+				dmas = <&dmac1 9>,
+				     <&dmac1 4>;
+				dma-names = "rx", "tx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&clks 19>;
@@ -308,8 +308,9 @@
 				reg = <0xb0170000 0x10000>;
 				interrupts = <16>;
 				sirf,spi-num-chipselects = <1>;
-				sirf,spi-dma-rx-channel = <12>;
-				sirf,spi-dma-tx-channel = <13>;
+				dmas = <&dmac0 12>,
+				     <&dmac0 13>;
+				dma-names = "rx", "tx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&clks 20>;
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 0e21993..6423771 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -310,8 +310,9 @@
 				reg = <0xb00d0000 0x10000>;
 				interrupts = <15>;
 				sirf,spi-num-chipselects = <1>;
-				sirf,spi-dma-rx-channel = <25>;
-				sirf,spi-dma-tx-channel = <20>;
+				dmas = <&dmac1 9>,
+				     <&dmac1 4>;
+				dma-names = "rx", "tx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&clks 19>;
@@ -324,8 +325,9 @@
 				reg = <0xb0170000 0x10000>;
 				interrupts = <16>;
 				sirf,spi-num-chipselects = <1>;
-				sirf,spi-dma-rx-channel = <12>;
-				sirf,spi-dma-tx-channel = <13>;
+				dmas = <&dmac0 12>,
+				     <&dmac0 13>;
+				dma-names = "rx", "tx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&clks 20>;
-- 
1.7.9.5
