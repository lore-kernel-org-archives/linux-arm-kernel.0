From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Apr 2017 10:06:18 +0900
Subject: [PATCH] arm64: dts: m3ulcb: Fix EthernetAVB PHY timing
Message-ID: <1492477578-10228-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set PHY rxc-skew-ps to 1500 and all other values to their default values.

This is intended to to address failures in the case of 1Gbps communication
using the by salvator-x board with the KSZ9031RNX phy. This has been
reported to occur with both the r8a7795 (H3) and r8a7796 (M3-W) SoCs.

Based in a similar patch for the r8a7796 salvator-x by Kazuya Mizuguchi.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Untested due to lack of hardware access.
---
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index c2a4549d3738..440d93e8388d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -169,18 +169,7 @@
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
