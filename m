From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 10:01:00 +0200
Subject: [PATCH v5 08/22] ARM: dts: sun4i-a10: Use system-control compatible
In-Reply-To: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180710080114.31469-9-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the sun4i-a10 dtsi to use the new compatible for the
system-control block (previously named SRAM controller) instead of
the deprecated one.

The phandle is also updated to reflect the fact that the controller
described is really about system control rather than SRAM control.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 3a1c6b45c9a1..82f81f06f201 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -190,8 +190,8 @@
 		#size-cells = <1>;
 		ranges;
 
-		sram-controller at 1c00000 {
-			compatible = "allwinner,sun4i-a10-sram-controller";
+		system-control at 1c00000 {
+			compatible = "allwinner,sun4i-a10-system-control";
 			reg = <0x01c00000 0x30>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.17.1
