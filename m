From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 29 Dec 2014 12:09:24 +0100
Subject: [PATCH v3 1/3] ARM: dts: sun6i: Add ir node
Message-ID: <1419851366-21945-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the ir receiver found on the A31.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-Add "ir" label to the ir node
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index e46dc2a..6de6aaf 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -904,6 +904,16 @@
 			reg = <0x01f01c00 0x300>;
 		};
 
+		ir: ir at 01f02000 {
+			compatible = "allwinner,sun5i-a13-ir";
+			clocks = <&apb0_gates 1>, <&ir_clk>;
+			clock-names = "apb", "ir";
+			resets = <&apb0_rst 1>;
+			interrupts = <0 37 4>;
+			reg = <0x01f02000 0x40>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl at 01f02c00 {
 			compatible = "allwinner,sun6i-a31-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.1.0
