From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:14 +0100
Subject: [PATCH 73/77] ARM: dts: sun8i: v3s: Fix Display Engine DTC warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <90cd636016416bb35b873bccf01faeeec0346da2.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our display engine endpoints trigger some DTC warnings due to the fact that
we're having a single endpoint that doesn't need any reg property, and
since we don't have a reg property, we don't need the address-cells and
size-cells properties anymore.

Fix those

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 21e1806ca509..7918064e0940 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -129,12 +129,9 @@
 				#size-cells = <0>;
 
 				mixer0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					mixer0_out_tcon0: endpoint at 0 {
-						reg = <0>;
+					mixer0_out_tcon0: endpoint {
 						remote-endpoint = <&tcon0_in_mixer0>;
 					};
 				};
@@ -159,12 +156,9 @@
 				#size-cells = <0>;
 
 				tcon0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					tcon0_in_mixer0: endpoint at 0 {
-						reg = <0>;
+					tcon0_in_mixer0: endpoint {
 						remote-endpoint = <&mixer0_out_tcon0>;
 					};
 				};
-- 
git-series 0.9.1
