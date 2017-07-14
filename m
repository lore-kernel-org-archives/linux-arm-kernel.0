From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 14 Jul 2017 10:04:47 +0200
Subject: [PATCH] arm64: dts: renesas: ulcb: sound clock-frequency needs
 descending order
In-Reply-To: <cover.1500019167.git.horms+renesas@verge.net.au>
References: <cover.1500019167.git.horms+renesas@verge.net.au>
Message-ID: <2752660a37aed65b1e00fd4563d9f152eefb8200.1500019167.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>

Correct order of sound clock frequencies for ULCB boards
used with r8a7795 and r8a7796 SoCs.

These sounds clock frequencies are used as the ADG clock (output clocks
for audio module) initial setting and sound codec's initial system clock
which needs the maximum clock frequency. Thus, descending order is
required.

Fixes: 9f22774c214ada7b ("arm64: dts: ulcb: add 12288000 for sound ADG")
Signed-off-by: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: rewrote changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index b5c6ee07d7f9..d1a3f3b7a0ab 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -281,7 +281,7 @@
 
 	/* audio_clkout0/1/2/3 */
 	#clock-cells = <1>;
-	clock-frequency = <11289600 12288000>;
+	clock-frequency = <12288000 11289600>;
 
 	status = "okay";
 
-- 
2.1.4
