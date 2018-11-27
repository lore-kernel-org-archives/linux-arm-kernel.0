From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:05 +0100
Subject: [PATCH 04/77] ARM: dts: sun5i: Fix display pipeline endpoint warnings
 in DTC
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <78b27a15e3e8c08ad565055a137d1954d5b0bb99.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since most of the display IPs have a single endpoint, having a reg
property, a unit-address and #address-cells and #size-cells will emit a
warning.

Let's remove those.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 14a7d1cf89b4..3e7b251ce7a6 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -238,11 +238,8 @@
 			status = "disabled";
 
 			port {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				tve0_in_tcon0: endpoint at 0 {
-					reg = <0>;
+				tve0_in_tcon0: endpoint {
 					remote-endpoint = <&tcon0_out_tve0>;
 				};
 			};
@@ -285,12 +282,9 @@
 				#size-cells = <0>;
 
 				tcon0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					tcon0_in_be0: endpoint at 0 {
-						reg = <0>;
+					tcon0_in_be0: endpoint {
 						remote-endpoint = <&be0_out_tcon0>;
 					};
 				};
@@ -726,12 +720,9 @@
 				#size-cells = <0>;
 
 				fe0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					fe0_out_be0: endpoint at 0 {
-						reg = <0>;
+					fe0_out_be0: endpoint {
 						remote-endpoint = <&be0_in_fe0>;
 					};
 				};
@@ -757,23 +748,17 @@
 				#size-cells = <0>;
 
 				be0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					be0_in_fe0: endpoint at 0 {
-						reg = <0>;
+					be0_in_fe0: endpoint {
 						remote-endpoint = <&fe0_out_be0>;
 					};
 				};
 
 				be0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					be0_out_tcon0: endpoint at 0 {
-						reg = <0>;
+					be0_out_tcon0: endpoint {
 						remote-endpoint = <&tcon0_in_be0>;
 					};
 				};
-- 
git-series 0.9.1
