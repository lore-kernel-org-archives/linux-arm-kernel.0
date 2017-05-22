From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:18 +0200
Subject: [PATCH 08/14] ARM: dts: r8a7793: update PFC node name to
 pin-controller
In-Reply-To: <cover.1495455272.git.horms+renesas@verge.net.au>
References: <cover.1495455272.git.horms+renesas@verge.net.au>
Message-ID: <5506dc4a8ebc2258e01a536b025bad17b6828da8.1495455272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device trees for Renesas SoCs use either pfc or pin-controller as the
node name for the PFC device. This patch is intended to take a step towards
unifying the node name used as pin-controller which appears to be the more
generic of the two and thus more in keeping with the DT specs.

My analysis is that this is a user-visible change to the extent that kernel
logs, and sysfs entries change from e6060000.pfc and pfc at e6060000 to
e6060000.pin-controller and pin-controller at e6060000.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 4de6041d61f9..728b5bca5bdb 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -529,7 +529,7 @@
 		status = "disabled";
 	};
 
-	pfc: pfc at e6060000 {
+	pfc: pin-controller at e6060000 {
 		compatible = "renesas,pfc-r8a7793";
 		reg = <0 0xe6060000 0 0x250>;
 	};
-- 
2.1.4
