From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:15 +0200
Subject: [PATCH 05/14] ARM: dts: r8a7779: update PFC node name to
 pin-controller
In-Reply-To: <cover.1495455272.git.horms+renesas@verge.net.au>
References: <cover.1495455272.git.horms+renesas@verge.net.au>
Message-ID: <b07b763c5255cf400ddfd4b6a7899adf0538dea9.1495455272.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index ae2d9a9c65af..8ee0b2ca5d39 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -286,7 +286,7 @@
 		status = "disabled";
 	};
 
-	pfc: pfc at fffc0000 {
+	pfc: pin-controller at fffc0000 {
 		compatible = "renesas,pfc-r8a7779";
 		reg = <0xfffc0000 0x23c>;
 	};
-- 
2.1.4
