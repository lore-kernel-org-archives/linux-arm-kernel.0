From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:21 +0100
Subject: [PATCH 10/32] arm64: dts: r8a7796: salvator-x: Fix EthernetAVB PHY
 timing
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <ef3f08c83fd186ab4bbad6a6250c5a347fbf6551.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Set PHY rxc-skew-ps to 1500 and all other values to their default values.

This is intended to to address failures in the case of 1Gbps communication
using the by salvator-x board with the KSZ9031RNX phy. This has been
reported to occur with both the r8a7795 (H3) and r8a7796 (M3-W) SoCs.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 61f4662db497..93ed23ab71bb 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -172,18 +172,7 @@
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
-		rxc-skew-ps = <900>;
-		rxdv-skew-ps = <0>;
-		rxd0-skew-ps = <0>;
-		rxd1-skew-ps = <0>;
-		rxd2-skew-ps = <0>;
-		rxd3-skew-ps = <0>;
-		txc-skew-ps = <900>;
-		txen-skew-ps = <0>;
-		txd0-skew-ps = <0>;
-		txd1-skew-ps = <0>;
-		txd2-skew-ps = <0>;
-		txd3-skew-ps = <0>;
+		rxc-skew-ps = <1500>;
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-- 
2.7.0.rc3.207.g0ac5344
