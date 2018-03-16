From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:16 +0100
Subject: [PATCH 46/69] arm64: dts: renesas: r8a77965: Add #phy-cells property
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <8a93a581457af7475aa8e874402d6ec1e4ee665c.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add "#phy-cells" property to "usb-phy at e65ee000" device node.

This silences the following DTC compiler warning:
Warning (phys_property): Missing property '#phy-cells' in node
/soc/usb-phy at e65ee000 or bad phandle (referred from
/soc/usb at ee020000:phys[0])

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 0536b94a5ec0..1a219674201f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -795,6 +795,7 @@
 
 		usb3_phy0: usb-phy at e65ee000 {
 			reg = <0 0xe65ee000 0 0x90>;
+			#phy-cells = <0>;
 			/* placeholder */
 		};
 
-- 
2.11.0
