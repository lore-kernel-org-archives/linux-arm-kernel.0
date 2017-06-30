From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Jun 2017 11:16:26 +0200
Subject: [PATCH] arm64: renesas: salvator-common: sound clock-frequency needs
 descending order
In-Reply-To: <cover.1498814088.git.horms+renesas@verge.net.au>
References: <cover.1498814088.git.horms+renesas@verge.net.au>
Message-ID: <5e2feac330953fe75197aecb20c781400e2bf606.1498814088.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It will be used ADG clock initial settings, and will be
sound codec's initial system clock which needs maximum clock frequency.
Thus, descending order is required

Fixes: d37d2b3c0ec2708a ("arm64: dts: salvator-x: add 12288000 for sound ADG")
Fixes: 0b03c32db03d63de ("arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index aef35e0b685a..a451996f590a 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -508,7 +508,7 @@
 
 	/* audio_clkout0/1/2/3 */
 	#clock-cells = <1>;
-	clock-frequency = <11289600 12288000>;
+	clock-frequency = <12288000 11289600>;
 
 	status = "okay";
 
-- 
2.1.4
