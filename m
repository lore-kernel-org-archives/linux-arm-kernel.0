From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:43 +0900
Subject: [PATCH 17/29] ARM: shmobile: koelsch: Sound DMA support via DVC on DTS
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <5c6d4b947aeca23e10f7d4ddf2041eda51b0ded2.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMA transfer uses DVC

     DMA               DMApp
[MEM] -> [SRC] -> [DVC] -> [SSIU] -> [SSI]

     DMA               DMApp
[MEM] <- [DVC] <- [SRC] <- [SSIU] <- [SSI]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d2fe677..f056e64 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -20,6 +20,13 @@
  * This command is required when Playback/Capture
  *
  *	amixer set "LINEOUT Mixer DACL" on
+ *	amixer set "DVC Out" 100%
+ *	amixer set "DVC In" 100%
+ *
+ * You can use Mute
+ *
+ *	amixer set "DVC Out Mute" on
+ *	amixer set "DVC In Mute" on
  */
 
 /dts-v1/;
@@ -569,8 +576,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi0 &src2>;
-			capture  = <&ssi1 &src3>;
+			playback = <&ssi0 &src2 &dvc0>;
+			capture  = <&ssi1 &src3 &dvc1>;
 		};
 	};
 };
-- 
2.1.1
