From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 17 Dec 2014 18:18:19 +0100
Subject: [PATCH v2 08/13] ARM: dts: sun6i: Add ir_clk node
In-Reply-To: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
References: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1418836704-15689-9-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an ir_clk sub-node to the prcm node.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use allwinner,sun4i-a10-mod0-clk as compatible, rather then a prcm specific
 compatible
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f47156b..1c1d255 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -878,6 +878,13 @@
 						"apb0_i2c";
 			};
 
+			ir_clk: ir_clk {
+				#clock-cells = <0>;
+				compatible = "allwinner,sun4i-a10-mod0-clk";
+				clocks = <&osc32k>, <&osc24M>;
+				clock-output-names = "ir";
+			};
+
 			apb0_rst: apb0_rst {
 				compatible = "allwinner,sun6i-a31-clock-reset";
 				#reset-cells = <1>;
-- 
2.1.0
