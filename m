From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:00 +0800
Subject: [PATCH 03/15] dt-bindings: rtc: sun6i-rtc: Deprecate external clock
 output for A31
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 does not have an external clock output directly from the RTC.
Instead, it has four muxable clock outputs: three (A, B, C) are
controlled from the CCU, and the last (D) is controlled from the PRCM.

Deprecate the usage of the external clock output for the A31 compatible.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index b1eaa443347d..78c4fb472eb7 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -30,6 +30,8 @@ Required properties for new device trees
 The RTC provides the following clocks at the given indices:
 - 0: LOSC
 - 1: LOSC external output, known as X32KFOUT in the datasheet.
+     This clock is not available on the A31 and is deprecated for old
+     device trees still using the "allwinner,sun6i-a31-rtc" compatible.
 
 Example:
 
@@ -37,7 +39,7 @@ rtc: rtc at 1f00000 {
 	compatible = "allwinner,sun6i-a31-rtc";
 	reg = <0x01f00000 0x54>;
 	interrupts = <0 40 4>, <0 41 4>;
-	clock-output-names = "osc32k", "osc32k-out";
+	clock-output-names = "osc32k";
 	clocks = <&ext_osc32k>;
 	#clock-cells = <1>;
 };
-- 
2.20.0.rc1
