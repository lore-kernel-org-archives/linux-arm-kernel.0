From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:10 +0200
Subject: [PATCH 02/11] arm64: dts: ulcb: add 12288000 for sound ADG
In-Reply-To: <cover.1497617276.git.horms+renesas@verge.net.au>
References: <cover.1497617276.git.horms+renesas@verge.net.au>
Message-ID: <9f22774c214ada7b951e312ca39a00e3878c560a.1497617276.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current rcar_sound only has 11289600 (= for 44.1kHz) clock-frequency,
but it needs 12288000 for 48kHz too.
Otherwise, 48kHz based sound can't handle correctly.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 41e83c8530f7..b5c6ee07d7f9 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -281,7 +281,7 @@
 
 	/* audio_clkout0/1/2/3 */
 	#clock-cells = <1>;
-	clock-frequency = <11289600>;
+	clock-frequency = <11289600 12288000>;
 
 	status = "okay";
 
-- 
2.1.4
