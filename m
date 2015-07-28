From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:04:00 +0000
Subject: [PATCH 06/10] ARM: dts: atlas7: add lost G2D node
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-7-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dongli Li <Kasin.Li@csr.com>

this patch adds lost G2D node, and also fixes the range of its
parent node.

Signed-off-by: Dongli Li <Kasin.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 5a98485..9bad559 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1865,7 +1865,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x13100000 0x13100000 0x20000>,
-				 <0x10e10000 0x10e10000 0x10000>;
+				<0x10e10000 0x10e10000 0x10000>,
+				<0x17010000 0x17010000 0x10000>;
 
 			lcd at 13100000 {
 				compatible = "sirf,atlas7-lcdc";
@@ -1887,6 +1888,12 @@
 				clocks = <&car 54>;
 				resets = <&car 29>;
 			};
+			g2d at 17010000 {
+				compatible = "sirf, atlas7-g2d";
+				reg = <0x17010000 0x10000>;
+				interrupts = <0 61 0>;
+				clocks = <&car 104>;
+			};
 
 		};
 
-- 
1.9.1
