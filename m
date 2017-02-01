From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  1 Feb 2017 14:31:43 +0000
Subject: [PATCH v2 08/10] ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW
 flow-control
In-Reply-To: <20170201143145.31962-1-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Message-ID: <20170201143145.31962-9-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each serial port which supports HW flow-control should have 2 Pinctrl
groups.  One for when HW flow-control is in progress, where the IP
will take over controlling the lines and another group which enables
the lines to be toggled using GPIO mechanisms.

Acked-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index daab16b..bd1a82e 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -465,8 +465,16 @@
 			serial0 {
 				pinctrl_serial0: serial0-0 {
 					st,pins {
-						tx = <&pio17 0 ALT1 OUT>;
-						rx = <&pio17 1 ALT1 IN>;
+						tx =  <&pio17 0 ALT1 OUT>;
+						rx =  <&pio17 1 ALT1 IN>;
+					};
+				};
+				pinctrl_serial0_hw_flowctrl: serial0-0_hw_flowctrl {
+					st,pins {
+						tx =  <&pio17 0 ALT1 OUT>;
+						rx =  <&pio17 1 ALT1 IN>;
+						cts = <&pio17 2 ALT1 IN>;
+						rts = <&pio17 3 ALT1 OUT>;
 					};
 				};
 			};
-- 
2.9.3
