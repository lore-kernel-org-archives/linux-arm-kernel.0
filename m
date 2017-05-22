From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:12 +0200
Subject: [PATCH 02/14] ARM: dts: r8a73a4: update PFC node name to
 pin-controller
In-Reply-To: <cover.1495455272.git.horms+renesas@verge.net.au>
References: <cover.1495455272.git.horms+renesas@verge.net.au>
Message-ID: <5b9906c9ee3b7117273467e3e74ecbd8f93ea730.1495455272.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 1f5c9f6dddba..310222634570 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -219,7 +219,7 @@
 		power-domains = <&pd_c4>;
 	};
 
-	pfc: pfc at e6050000 {
+	pfc: pin-controller at e6050000 {
 		compatible = "renesas,pfc-r8a73a4";
 		reg = <0 0xe6050000 0 0x9000>;
 		gpio-controller;
-- 
2.1.4
