From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Apr 2017 12:05:30 +0200
Subject: [PATCH 1/9] ARM: dts: emev2: update PFC node name to pin-controller
In-Reply-To: <20170426100538.22060-1-horms+renesas@verge.net.au>
References: <20170426100538.22060-1-horms+renesas@verge.net.au>
Message-ID: <20170426100538.22060-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device trees for Renesas SoCs use either pfc or pin-controller as the
node name for the PFC device. This patch is intended to take a step towards
unifying the node name used as pin-controller which appears to be the more
generic of the two and thus more in keeping with the DT specs.

My analysis is that this is a user-visible change to the extent that kernel
logs, and sysfs entries change from e0140200.pfc and pfc at e0140200 to
e0140200.pin-controller and pin-controller at e0140200.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 0124faf175c8..42ea246e71cb 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -197,7 +197,7 @@
 		clock-names = "sclk";
 	};
 
-	pfc: pfc at e0140200 {
+	pfc: pin-controller at e0140200 {
 		compatible = "renesas,pfc-emev2";
 		reg = <0xe0140200 0x100>;
 	};
-- 
2.12.2.816.g2cccc81164
