From: eric@anholt.net (Eric Anholt)
Date: Thu, 24 Mar 2016 17:23:51 -0700
Subject: [PATCH 5/5] ARM: bcm2835: Add the DPI hardware to the device tree.
In-Reply-To: <1458865431-30048-1-git-send-email-eric@anholt.net>
References: <1458865431-30048-1-git-send-email-eric@anholt.net>
Message-ID: <1458865431-30048-6-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's currently marked disabled, as it's not useful without a panel
associated with it and the GPIO pins routed to ALT2.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index bbe4eab..d1e6340 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -166,6 +166,17 @@
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
 		aux: aux at 0x7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
-- 
2.7.0
