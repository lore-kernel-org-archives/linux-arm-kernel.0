From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Aug 2017 10:56:35 +0200
Subject: [PATCH] arm64: renesas: salvator-common: avoid audio_clkout naming
 conflict
In-Reply-To: <cover.1502959921.git.horms+renesas@verge.net.au>
References: <cover.1502959921.git.horms+renesas@verge.net.au>
Message-ID: <8cd7b51ff57c74260b20c97623b0e0d420c22be8.1502959921.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

clock name of "audio_clkout" is used by Renesas sound driver.
This duplicated naming breaks its clock registering/unregistering.
Especially, when unbind/bind it can't handle clkout correctly.
This patch renames "audio_clkout" to "audio-clkout" to avoid
naming conflict.

Fixes: 8a8f181d2cfd ("arm64: renesas: salvator-x: use CS2000 as AUDIO_CLK_B")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index a451996f590a..f903957da504 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -45,7 +45,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	audio_clkout: audio_clkout {
+	audio_clkout: audio-clkout {
 		/*
 		 * This is same as <&rcar_sound 0>
 		 * but needed to avoid cs2000/rcar_sound probe dead-lock
-- 
2.1.4
