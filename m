From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:34 +0800
Subject: [PATCH 5/9] arm/dts: sirf: add missed cell,
 cs and dma channel for SPI nodes
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-6-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

here we need to add missed cell, cs and dma channels prop in SPI nodes
to match with drivers.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |  5 +++++
 arch/arm/boot/dts/prima2.dtsi | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 54cb13b..6e6ddbc 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -295,6 +295,11 @@
 				compatible = "sirf,prima2-spi";
 				reg = <0xb0170000 0x10000>;
 				interrupts = <16>;
+				sirf,spi-num-chipselects = <1>;
+				sirf,spi-dma-rx-channel = <12>;
+				sirf,spi-dma-tx-channel = <13>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&clks 20>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 39154aa9..244156f 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -296,7 +296,13 @@
 				compatible = "sirf,prima2-spi";
 				reg = <0xb00d0000 0x10000>;
 				interrupts = <15>;
+				sirf,spi-num-chipselects = <1>;
+				sirf,spi-dma-rx-channel = <25>;
+				sirf,spi-dma-tx-channel = <20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&clks 19>;
+				status = "disabled";
 			};
 
 			spi1: spi at b0170000 {
@@ -304,7 +310,13 @@
 				compatible = "sirf,prima2-spi";
 				reg = <0xb0170000 0x10000>;
 				interrupts = <16>;
+				sirf,spi-num-chipselects = <1>;
+				sirf,spi-dma-rx-channel = <12>;
+				sirf,spi-dma-tx-channel = <13>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&clks 20>;
+				status = "disabled";
 			};
 
 			i2c0: i2c at b00e0000 {
-- 
1.8.2.3
