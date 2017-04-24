From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 24 Apr 2017 10:51:55 +0200
Subject: [PATCH] arm64: dts: r8a7795: update PFC node name to pin-controller
Message-ID: <1493023915-21658-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device trees for Renesas SoCs use either pfc or pin-controller
as the node name for the PFC device. This patch is intended to take a step
towards unifying the node name used as pin-controller which appears to
be more the more generic of the two and thus more in keeping with the DT
specs.

My analysis is that this is a user-visible change to the extent that kernel
logs, and sysfs entries change from e6060000.pfc and pfc at e6060000 to
e6060000.pin-controller and pin-controller at e6060000.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Before:
/sys/kernel/debug/pinctrl/e6060000.pfc
/sys/devices/platform/soc/e6060000.pfc
/sys/firmware/devicetree/base/soc/pfc at e6060000
/sys/bus/platform/devices/e6060000.pfc
/sys/bus/platform/drivers/sh-pfc
/sys/bus/platform/drivers/sh-pfc/e6060000.pfc

After:
/sys/kernel/debug/pinctrl/e6060000.pin-controller
/sys/devices/platform/soc/e6060000.pin-controller
/sys/firmware/devicetree/base/soc/pin-controller at e6060000
/sys/bus/platform/devices/e6060000.pin-controller
/sys/bus/platform/drivers/sh-pfc
/sys/bus/platform/drivers/sh-pfc/e6060000.pin-controller
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e99d6443b3e4..7d87dff70ac8 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -398,7 +398,7 @@
 			#power-domain-cells = <1>;
 		};
 
-		pfc: pfc at e6060000 {
+		pfc: pin-controller at e6060000 {
 			compatible = "renesas,pfc-r8a7795";
 			reg = <0 0xe6060000 0 0x50c>;
 		};
-- 
2.7.0.rc3.207.g0ac5344
