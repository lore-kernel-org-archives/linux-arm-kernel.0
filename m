From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:29:58 +0800
Subject: [PATCH 01/15] dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a
 list
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock output section for this binding describes the two outputs in
the descriptions for both the #clock-cells and clock-output-names
properties.

Instead of overlapping information that is hard to read, rewrite the
clock outputs as a list of indices and descriptions. The properies
can reference this list instead. This will also make it easier to
add notes or conditions to the clocks, and also for adding new outputs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index 12c083c1140a..d3e96459fc66 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -10,10 +10,12 @@ Required properties:
 
 Required properties for new device trees
 - clocks	: phandle to the 32kHz external oscillator
-- clock-output-names : names of the LOSC and its external output clocks created
-- #clock-cells  : must be equals to 1. The RTC provides two clocks: the
-		  LOSC and its external output, with index 0 and 1
-		  respectively.
+- clock-output-names : names of the two clock outputs. See below.
+- #clock-cells  : must be equal to 1.
+
+The RTC provides the following clocks at the given indices:
+- 0: LOSC
+- 1: LOSC external output, known as X32KFOUT in the datasheet.
 
 Example:
 
-- 
2.20.0.rc1
