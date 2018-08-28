From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 28 Aug 2018 22:45:42 +0200
Subject: [PATCH 2/4] arm64: dts: fsl: ls1046a: disable uarts by default
In-Reply-To: <20180828204544.10815-1-alexandre.belloni@bootlin.com>
References: <20180828204544.10815-1-alexandre.belloni@bootlin.com>
Message-ID: <20180828204544.10815-2-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the UARTs by defaultto avoid registering unused UARTs. This
effectively change the number of registered UARTS for the RDB and QDS from
4 to 2 but this seems the right thing to do.

It is especially useful when connecting other 8250 uart on PCIe for example
as the default maximum number of 8250 UARTs that can be registered is 4.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 2d8122019cd8..62ae3ee19d6f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -423,6 +423,7 @@
 			reg = <0x00 0x21c0500 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		duart1: serial at 21c0600 {
@@ -430,6 +431,7 @@
 			reg = <0x00 0x21c0600 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		duart2: serial at 21d0500 {
@@ -437,6 +439,7 @@
 			reg = <0x0 0x21d0500 0x0 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		duart3: serial at 21d0600 {
@@ -444,6 +447,7 @@
 			reg = <0x0 0x21d0600 0x0 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			status = "disabled";
 		};
 
 		gpio0: gpio at 2300000 {
-- 
2.18.0
