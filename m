From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:13 +0200
Subject: [PATCH 03/14] ARM: dts: r8a7740: update PFC node name to
 pin-controller
In-Reply-To: <cover.1495455272.git.horms+renesas@verge.net.au>
References: <cover.1495455272.git.horms+renesas@verge.net.au>
Message-ID: <9d65683f6e228df6b3b0e6b74de4729a782b1e65.1495455272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device trees for Renesas SoCs use either pfc or pin-controller as the
node name for the PFC device. This patch is intended to take a step towards
unifying the node name used as pin-controller which appears to be the more
generic of the two and thus more in keeping with the DT specs.

My analysis is that this is a user-visible change to the extent that kernel
logs, and sysfs entries change from e6050000.pfc and pfc at e6050000 to
e6050000.pin-controller and pin-controller at e6050000.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 34159a8349de..d37d22682a63 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -299,7 +299,7 @@
 		status = "disabled";
 	};
 
-	pfc: pfc at e6050000 {
+	pfc: pin-controller at e6050000 {
 		compatible = "renesas,pfc-r8a7740";
 		reg = <0xe6050000 0x8000>,
 		      <0xe605800c 0x20>;
-- 
2.1.4
