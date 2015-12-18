From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:36 +0900
Subject: [PATCH 06/25] ARM: shmobile: bockw dts: Override #sound-dai-cells to
 zero
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <a6ff5e8d5ebc0392d5c470652cd22f730e090e29.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The default value of #sound-dai-cells in r8a7778.dtsi is one, while
the /sound/simple-audio-card,cpu device node in r8a7778-bockw.dts uses a
phandle without any extra cells ("<&rcar_sound>"), causing:

    /sound/simple-audio-card,cpu: arguments longer than property
    asoc-simple-card sound: parse error -22
    asoc-simple-card: probe of sound failed with error -22

Override #sound-dai-cells to zero to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 3c03e6b8261e..158ad94fd4d1 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -172,6 +172,11 @@
 	};
 };
 
+&rcar_sound {
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>, <&sdhi0_pup_pins>;
 	pinctrl-names = "default";
-- 
2.1.4
