From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Apr 2017 12:05:38 +0200
Subject: [PATCH 9/9] ARM: dts: sh73a0: update PFC node name to pin-controller
In-Reply-To: <20170426100538.22060-1-horms+renesas@verge.net.au>
References: <20170426100538.22060-1-horms+renesas@verge.net.au>
Message-ID: <20170426100538.22060-10-horms+renesas@verge.net.au>
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
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 6b01ab354e88..4ea5c5a16c57 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -444,7 +444,7 @@
 		status = "disabled";
 	};
 
-	pfc: pfc at e6050000 {
+	pfc: pin-controller at e6050000 {
 		compatible = "renesas,pfc-sh73a0";
 		reg = <0xe6050000 0x8000>,
 		      <0xe605801c 0x1c>;
-- 
2.12.2.816.g2cccc81164
