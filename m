From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Feb 2017 09:42:02 +0100
Subject: [PATCH 3/5] arm64: dts: h3ulcb: Fix EthernetAVB PHY timing
In-Reply-To: <1485938524-9322-1-git-send-email-horms+renesas@verge.net.au>
References: <1485938524-9322-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1485938524-9322-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Set PHY rxc-skew-ps to 1500 and all other values to their default values.

This is intended to to address failures in the case of 1Gbps communication
using the by h3ulcb board with the KSZ9031RNX phy.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v1 [Simon Horman]
* Do not set values to defaults, omit them and let the driver set the defaults
* Rewrote changelog

  N.B. I have not tested this patch as I do not have access to an h3ulcb

v0 [Vladimir Barinov]
---
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index c5f8f69a4f5f..baaa9330cfab 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -339,18 +339,7 @@
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
