From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:33 +0800
Subject: [PATCH 4/9] arm/dts: sirf: fix fifosize, clks, dma channels for UART
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-5-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

sirf uart and usp-based uart driver with full dma support has
hit 3.12, here we fix the fifosize, dma channels for some HW
prop.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 10 ++++++++++
 arch/arm/boot/dts/prima2.dtsi | 22 +++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index b439b74..54cb13b 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -207,6 +207,8 @@
 				interrupts = <17>;
 				fifosize = <128>;
 				clocks = <&clks 13>;
+				sirf,uart-dma-rx-channel = <21>;
+				sirf,uart-dma-tx-channel = <2>;
 			};
 
 			uart1: uart at b0060000 {
@@ -225,6 +227,8 @@
 				interrupts = <19>;
 				fifosize = <128>;
 				clocks = <&clks 15>;
+				sirf,uart-dma-rx-channel = <6>;
+				sirf,uart-dma-tx-channel = <7>;
 			};
 
 			usp0: usp at b0080000 {
@@ -232,7 +236,10 @@
 				compatible = "sirf,prima2-usp";
 				reg = <0xb0080000 0x10000>;
 				interrupts = <20>;
+				fifosize = <128>;
 				clocks = <&clks 28>;
+				sirf,usp-dma-rx-channel = <17>;
+				sirf,usp-dma-tx-channel = <18>;
 			};
 
 			usp1: usp at b0090000 {
@@ -240,7 +247,10 @@
 				compatible = "sirf,prima2-usp";
 				reg = <0xb0090000 0x10000>;
 				interrupts = <21>;
+				fifosize = <128>;
 				clocks = <&clks 29>;
+				sirf,usp-dma-rx-channel = <14>;
+				sirf,usp-dma-tx-channel = <15>;
 			};
 
 			dmac0: dma-controller at b00b0000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 8c393bc..39154aa9 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -208,25 +208,32 @@
 			uart0: uart at b0050000 {
 				cell-index = <0>;
 				compatible = "sirf,prima2-uart";
-				reg = <0xb0050000 0x10000>;
+				reg = <0xb0050000 0x1000>;
 				interrupts = <17>;
+				fifosize = <128>;
 				clocks = <&clks 13>;
+				sirf,uart-dma-rx-channel = <21>;
+				sirf,uart-dma-tx-channel = <2>;
 			};
 
 			uart1: uart at b0060000 {
 				cell-index = <1>;
 				compatible = "sirf,prima2-uart";
-				reg = <0xb0060000 0x10000>;
+				reg = <0xb0060000 0x1000>;
 				interrupts = <18>;
+				fifosize = <32>;
 				clocks = <&clks 14>;
 			};
 
 			uart2: uart at b0070000 {
 				cell-index = <2>;
 				compatible = "sirf,prima2-uart";
-				reg = <0xb0070000 0x10000>;
+				reg = <0xb0070000 0x1000>;
 				interrupts = <19>;
+				fifosize = <128>;
 				clocks = <&clks 15>;
+				sirf,uart-dma-rx-channel = <6>;
+				sirf,uart-dma-tx-channel = <7>;
 			};
 
 			usp0: usp at b0080000 {
@@ -234,7 +241,10 @@
 				compatible = "sirf,prima2-usp";
 				reg = <0xb0080000 0x10000>;
 				interrupts = <20>;
+				fifosize = <128>;
 				clocks = <&clks 28>;
+				sirf,usp-dma-rx-channel = <17>;
+				sirf,usp-dma-tx-channel = <18>;
 			};
 
 			usp1: usp at b0090000 {
@@ -242,7 +252,10 @@
 				compatible = "sirf,prima2-usp";
 				reg = <0xb0090000 0x10000>;
 				interrupts = <21>;
+				fifosize = <128>;
 				clocks = <&clks 29>;
+				sirf,usp-dma-rx-channel = <14>;
+				sirf,usp-dma-tx-channel = <15>;
 			};
 
 			usp2: usp at b00a0000 {
@@ -250,7 +263,10 @@
 				compatible = "sirf,prima2-usp";
 				reg = <0xb00a0000 0x10000>;
 				interrupts = <22>;
+				fifosize = <128>;
 				clocks = <&clks 30>;
+				sirf,usp-dma-rx-channel = <10>;
+				sirf,usp-dma-tx-channel = <11>;
 			};
 
 			dmac0: dma-controller at b00b0000 {
-- 
1.8.2.3
