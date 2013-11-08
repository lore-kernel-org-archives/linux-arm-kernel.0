From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri,  8 Nov 2013 15:41:49 +0530
Subject: [PATCH v5 6/7] ARM: davinci: da850: add GPIO DT node
In-Reply-To: <1383905510-31760-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1383905510-31760-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <1383905510-31760-7-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KV Sujith <sujithkv@ti.com>

Add DT node for Davinci GPIO driver.

Signed-off-by: KV Sujith <sujithkv@ti.com>
Signed-off-by: Philip Avinash <avinashphilip@ti.com>
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/boot/dts/da850.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 8d17346..b695548 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -8,6 +8,7 @@
  * option) any later version.
  */
 #include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	arm {
@@ -256,6 +257,19 @@
 					36
 					>;
 		};
+		gpio: gpio at 1e26000 {
+			compatible = "ti,dm6441-gpio";
+			gpio-controller;
+			reg = <0x226000 0x1000>;
+			interrupts = <42 IRQ_TYPE_EDGE_BOTH
+				43 IRQ_TYPE_EDGE_BOTH 44 IRQ_TYPE_EDGE_BOTH
+				45 IRQ_TYPE_EDGE_BOTH 46 IRQ_TYPE_EDGE_BOTH
+				47 IRQ_TYPE_EDGE_BOTH 48 IRQ_TYPE_EDGE_BOTH
+				49 IRQ_TYPE_EDGE_BOTH 50 IRQ_TYPE_EDGE_BOTH>;
+			ti,ngpio = <144>;
+			ti,davinci-gpio-unbanked = <0>;
+			status = "disabled";
+		};
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
-- 
1.7.9.5
