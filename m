From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Sep 2017 15:50:09 +0800
Subject: [PATCH 1/8] ARM: dts: sun6i: Fix endpoint IDs in second display
 pipeline
In-Reply-To: <20170908075016.18657-1-wens@csie.org>
References: <20170908075016.18657-1-wens@csie.org>
Message-ID: <20170908075016.18657-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the second display pipeline device nodes for the A31/A31s were
added, it was not known that the TCONs could (through either DRCs)
select either backend as their input. Thus in the endpoints connecting
these components together, the endpoint IDs were set to 0, while in
fact they should have been set to 1.

Fixes: 9a26882a7378 ("ARM: dts: sun6i: Add second display pipeline device
		      nodes")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f3d74dc5b292..00a4c7614e0a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -311,8 +311,8 @@
 					#size-cells = <0>;
 					reg = <0>;
 
-					tcon1_in_drc1: endpoint at 0 {
-						reg = <0>;
+					tcon1_in_drc1: endpoint at 1 {
+						reg = <1>;
 						remote-endpoint = <&drc1_out_tcon1>;
 					};
 				};
@@ -1038,8 +1038,8 @@
 					#size-cells = <0>;
 					reg = <1>;
 
-					be1_out_drc1: endpoint at 0 {
-						reg = <0>;
+					be1_out_drc1: endpoint at 1 {
+						reg = <1>;
 						remote-endpoint = <&drc1_in_be1>;
 					};
 				};
@@ -1068,8 +1068,8 @@
 					#size-cells = <0>;
 					reg = <0>;
 
-					drc1_in_be1: endpoint at 0 {
-						reg = <0>;
+					drc1_in_be1: endpoint at 1 {
+						reg = <1>;
 						remote-endpoint = <&be1_out_drc1>;
 					};
 				};
@@ -1079,8 +1079,8 @@
 					#size-cells = <0>;
 					reg = <1>;
 
-					drc1_out_tcon1: endpoint at 0 {
-						reg = <0>;
+					drc1_out_tcon1: endpoint at 1 {
+						reg = <1>;
 						remote-endpoint = <&tcon1_in_drc1>;
 					};
 				};
-- 
2.14.1
