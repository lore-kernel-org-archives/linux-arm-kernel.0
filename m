From: eric@anholt.net (Eric Anholt)
Date: Fri,  9 Mar 2018 15:36:39 -0800
Subject: [PATCH] ARM: bcm2835: Add the DPI hardware to the device tree.
Message-ID: <20180309233639.2029-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's currently marked disabled, as it's not useful without a panel
associated with it and the GPIO pins routed to ALT2.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

This patch got misplaced as part of the original VC4 DPI work (which
included the binding).  I've got a full branch demoing a panel at
https://github.com/anholt/linux/commits/drm-vc4-dpi

 arch/arm/boot/dts/bcm283x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 18db25a5a66e..4359cb2aae22 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -438,6 +438,17 @@
 			interrupts = <2 14>; /* pwa1 */
 		};
 
+		dpi: dpi at 7e208000 {
+			compatible = "brcm,bcm2835-dpi";
+			reg = <0x7e208000 0x8c>;
+			clocks = <&clocks BCM2835_CLOCK_VPU>,
+				 <&clocks BCM2835_CLOCK_DPI>;
+			clock-names = "core", "pixel";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		dsi0: dsi at 7e209000 {
 			compatible = "brcm,bcm2835-dsi0";
 			reg = <0x7e209000 0x78>;
-- 
2.16.2
