From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:57:49 +0900
Subject: [PATCH 12/28] ARM: shmobile: koelsch: use CCF for audio clock
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <c19c84ff3ab1280894bb2cdd99027f751922e2ba.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Because of historical reason, audio clock didn't use CCF.
Let's use it now.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index dc158845afdc..fc44ea361a4b 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -242,6 +242,13 @@
 			  1800000 0>;
 	};
 
+	audio_clock: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <11289600>;
+		clock-output-names = "audio_clock";
+	};
+
 	rsnd_ak4643: sound {
 		compatible = "simple-audio-card";
 
@@ -255,7 +262,7 @@
 
 		sndcodec: simple-audio-card,codec {
 			sound-dai = <&ak4643>;
-			system-clock-frequency = <11289600>;
+			clocks = <&audio_clock>;
 		};
 	};
 
-- 
2.1.4
