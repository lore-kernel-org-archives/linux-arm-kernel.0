From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 25 Nov 2015 06:39:13 +0000
Subject: [PATCH 10/12] arm64: renesas: salvator-x: Sound DVC support
In-Reply-To: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
References: <8737vu8ucv.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87oaei7flt.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 27 ++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 47bf252..c5f709e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -8,6 +8,29 @@
  * kind, whether express or implied.
  */
 
+/*
+ * SSI-AK4613
+ *
+ * This command is required when Playback/Capture
+ *
+ *	amixer set "DVC Out" 100%
+ *	amixer set "DVC In" 100%
+ *
+ * You can use Mute
+ *
+ *	amixer set "DVC Out Mute" on
+ *	amixer set "DVC In Mute" on
+ *
+ * You can use Volume Ramp
+ *
+ *	amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
+ *	amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
+ *	amixer set "DVC Out Ramp" on
+ *	aplay xxx.wav &
+ *	amixer set "DVC Out"  80%  // Volume Down
+ *	amixer set "DVC Out" 100%  // Volume Up
+ */
+
 /dts-v1/;
 #include "r8a7795.dtsi"
 
@@ -136,8 +159,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi0 &src0>;
-			capture  = <&ssi1 &src1>;
+			playback = <&ssi0 &src0 &dvc0>;
+			capture  = <&ssi1 &src1 &dvc1>;
 		};
 	};
 };
-- 
1.9.1
