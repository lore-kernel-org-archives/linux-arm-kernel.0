From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 May 2014 13:59:58 +0200
Subject: [PATCH] ARM: sun6i: Fix OHCI2 node name
Message-ID: <1400587198-19668-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unit-address doesn't match the reg property. Since the reg property is
correct, change the unit-address accordingly.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 4155fc43ecff..0f4ea4990d2c 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -410,7 +410,7 @@
 			status = "disabled";
 		};
 
-		ohci2: usb at 01c1c000 {
+		ohci2: usb at 01c1c400 {
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <0 77 4>;
-- 
1.9.3
