From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:31 +0200
Subject: [PATCH 28/31] arm64: renesas: ulcb: fixup audio_clkout
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <822cecb1bef2bf41663d6c4e7786d9e159f72674.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

"audio_clkout" is dummy clock of <&rcar_sound 0> to avoid clock loop
which invites probe conflict. Thus <&rcar_sound 0> and "audio_clkout"
should be same value.

On commit 2752660a37ae ("arm64: dts: renesas: ulcb: sound
clock-frequency needs descending order") exchanged <&rcar_sound 0>,
but it didn't modify "audio_clkout".
This patch fixup it.

Fixes: 2752660a37ae ("arm64: dts: renesas: ulcb: sound clock-frequency needs descending order")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 1a5f15ae531f..0d85b315ce71 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -31,7 +31,7 @@
 		 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <11289600>;
+		clock-frequency = <12288000>;
 	};
 
 	hdmi0-out {
-- 
2.11.0
