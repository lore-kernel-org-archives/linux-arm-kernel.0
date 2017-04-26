From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Apr 2017 12:05:33 +0200
Subject: [PATCH 4/9] ARM: dts: r8a7778: update PFC node name to pin-controller
In-Reply-To: <20170426100538.22060-1-horms+renesas@verge.net.au>
References: <20170426100538.22060-1-horms+renesas@verge.net.au>
Message-ID: <20170426100538.22060-5-horms+renesas@verge.net.au>
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
2.12.2.816.g2cccc81164
