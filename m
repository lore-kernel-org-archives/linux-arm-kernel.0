From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  4 Jan 2018 00:31:55 +0800
Subject: [PATCH] ARM: dts: sun[47]i: Fix display backend 1 output to TCON0
 remote endpoint
Message-ID: <20180103163155.13975-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a copy-paste error in the display pipeline device tree graph.
The remote endpoint of the display backend 1's output to TCON0 points
to the wrong endpoint. This will result in the driver incorrectly
parsing the relationship of the components.

Reported-by: Andrea Venturi <ennesimamail.av@gmail.com>
Fixes: 0df4cf33a594 ("ARM: dts: sun4i: Add device nodes for display
		      pipelines")
Fixes: 5b92b29bed45 ("ARM: dts: sun7i: Add device nodes for display
		      pipelines")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This is a late fix for 4.15 that corrects an error in the newly
added display pipeline graph for the A10 and A20.

---
 arch/arm/boot/dts/sun4i-a10.dtsi | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 5840f5c75c3b..4f2f2eea0755 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1104,7 +1104,7 @@
 
 					be1_out_tcon0: endpoint at 0 {
 						reg = <0>;
-						remote-endpoint = <&tcon1_in_be0>;
+						remote-endpoint = <&tcon0_in_be1>;
 					};
 
 					be1_out_tcon1: endpoint at 1 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 59655e42e4b0..bd0cd3204273 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1354,7 +1354,7 @@
 
 					be1_out_tcon0: endpoint at 0 {
 						reg = <0>;
-						remote-endpoint = <&tcon1_in_be0>;
+						remote-endpoint = <&tcon0_in_be1>;
 					};
 
 					be1_out_tcon1: endpoint at 1 {
-- 
2.15.1
