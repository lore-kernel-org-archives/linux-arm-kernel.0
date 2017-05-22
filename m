From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:45 +0200
Subject: [PATCH 12/35] arm64: dts: r8a7795: update PFC node name to
 pin-controller
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <3e7a5b3c8d40b5251bdab82df6289493190583cd.1495457812.git.horms+renesas@verge.net.au>
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
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
2.1.4
