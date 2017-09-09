From: aford173@gmail.com (Adam Ford)
Date: Sat,  9 Sep 2017 07:28:37 -0500
Subject: [PATCH RFC] davinci: da850: define edma-memcpy-channels
Message-ID: <1504960117-24264-1-git-send-email-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with a device tree, message appears:
   memcpy is disabled
When reading through the bindings for eDMA3, it shows that
ti,edma-memcpy-channels is an optional property, but the example
binding uses it.

RFC:  I'll be the first to admit that I don't understand what
this is doing, but it seems like a DMA enabled memcpy would
improve performance.  Is this appropriate for da850?  Since there
are two eDMA3-tpcc controllers, is there a set of channels we can
use for each?

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index af68ef7..eacadb8 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -263,7 +263,7 @@
 			interrupts = <11 12>;
 			interrupt-names = "edma3_ccint", "edma3_ccerrint";
 			#dma-cells = <2>;
-
+			ti,edma-memcpy-channels = <20 21>;
 			ti,tptcs = <&edma0_tptc0 7>, <&edma0_tptc1 0>;
 		};
 		edma0_tptc0: tptc at 8000 {
-- 
2.7.4
