From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:28 +0100
Subject: [PATCH 02/40] arm64: dts: renesas: r8a7795: remove unneeded sound
 #address/size-cells
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <e20a1b9e10e3d01155bfd3faa2a49174ee16df08.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 2d87dc0e5be2 ("arm64: dts: renesas: r8a7795: Add address
properties to rcar_sound port nodes") added missing #address-cells
and #size-cells for sound ports.
But, these are based on platform, not on SoC. This patch cleanups it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts |  2 ++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts     |  2 ++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts    |  2 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi               | 14 --------------
 arch/arm64/boot/dts/renesas/salvator-common.dtsi       |  3 +++
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
index 0895503b69d0..c1a56eab7b24 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
@@ -112,6 +112,7 @@
 	ports {
 		/* rsnd_port0 is on salvator-common */
 		rsnd_port1: port at 1 {
+			reg = <1>;
 			rsnd_endpoint1: endpoint {
 				remote-endpoint = <&dw_hdmi0_snd_in>;
 
@@ -123,6 +124,7 @@
 			};
 		};
 		rsnd_port2: port at 2 {
+			reg = <2>;
 			rsnd_endpoint2: endpoint {
 				remote-endpoint = <&dw_hdmi1_snd_in>;
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 1620e8d8dacc..d2d48b33b37f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -112,6 +112,7 @@
 	ports {
 		/* rsnd_port0 is on salvator-common */
 		rsnd_port1: port at 1 {
+			reg = <1>;
 			rsnd_endpoint1: endpoint {
 				remote-endpoint = <&dw_hdmi0_snd_in>;
 
@@ -123,6 +124,7 @@
 			};
 		};
 		rsnd_port2: port at 2 {
+			reg = <2>;
 			rsnd_endpoint2: endpoint {
 				remote-endpoint = <&dw_hdmi1_snd_in>;
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index cf08a119eec0..42101fc76837 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -127,6 +127,7 @@
 	ports {
 		/* rsnd_port0 is on salvator-common */
 		rsnd_port1: port at 1 {
+			reg = <1>;
 			rsnd_endpoint1: endpoint {
 				remote-endpoint = <&dw_hdmi0_snd_in>;
 
@@ -138,6 +139,7 @@
 			};
 		};
 		rsnd_port2: port at 2 {
+			reg = <2>;
 			rsnd_endpoint2: endpoint {
 				remote-endpoint = <&dw_hdmi1_snd_in>;
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b5f2273caca4..95a8ed40e7d3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1972,20 +1972,6 @@
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 			};
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				port at 0 {
-					reg = <0>;
-				};
-				port at 1 {
-					reg = <1>;
-				};
-				port at 2 {
-					reg = <2>;
-				};
-			};
 		};
 
 		audma0: dma-controller at ec700000 {
diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 7f91ff524109..054a7eeeef92 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -707,7 +707,10 @@
 		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		rsnd_port0: port at 0 {
+			reg = <0>;
 			rsnd_endpoint0: endpoint {
 				remote-endpoint = <&ak4613_endpoint>;
 
-- 
2.11.0
