From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:14 +0200
Subject: [PATCH 04/14] ARM: dts: r8a7778: update PFC node name to
 pin-controller
In-Reply-To: <cover.1495455272.git.horms+renesas@verge.net.au>
References: <cover.1495455272.git.horms+renesas@verge.net.au>
Message-ID: <b3ed04985ce6d19a0cb12dccf95d41c1b86693cc.1495455272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device trees for Renesas SoCs use either pfc or pin-controller as the
node name for the PFC device. This patch is intended to take a step towards
unifying the node name used as pin-controller which appears to be the more
generic of the two and thus more in keeping with the DT specs.

My analysis is that this is a user-visible change to the extent that kernel
logs, and sysfs entries change from fffc0000.pfc and pfc at fffc0000 to
fffc0000.pin-controller and pin-controller at fffc0000.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 1e93c94a9eac..8f3156c0e575 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -142,7 +142,7 @@
 		interrupt-controller;
 	};
 
-	pfc: pfc at fffc0000 {
+	pfc: pin-controller at fffc0000 {
 		compatible = "renesas,pfc-r8a7778";
 		reg = <0xfffc0000 0x118>;
 	};
-- 
2.1.4
