From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 20 Nov 2014 21:30:19 +0800
Subject: [PATCH] ARM: dts: prima2: add resets property for GPS nodes
Message-ID: <1416490219-4185-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tao Huang <Tao.Huang@csr.com>

this patch adds missed resets property for CSR SiRFprimaII GPS
related nodes.

Change-Id: I5a08ae3e617b1e5066beb800bbd37e8b6cb77a9e
Signed-off-by: Tao Huang <Tao.Huang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 86dcb46..dd4b644 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -178,6 +178,7 @@
 				compatible = "sirf,prima2-dspif";
 				reg = <0xa8000000 0x10000>;
 				interrupts = <9>;
+				resets = <&rstc 1>;
 			};
 
 			gps at a8010000 {
@@ -185,6 +186,7 @@
 				reg = <0xa8010000 0x10000>;
 				interrupts = <7>;
 				clocks = <&clks 9>;
+				resets = <&rstc 2>;
 			};
 
 			dsp at a9000000 {
@@ -192,6 +194,7 @@
 				reg = <0xa9000000 0x1000000>;
 				interrupts = <8>;
 				clocks = <&clks 8>;
+				resets = <&rstc 0>;
 			};
 		};
 
-- 
2.1.1
