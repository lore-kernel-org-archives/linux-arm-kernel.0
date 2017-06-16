From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 17:24:29 +0530
Subject: [PATCH 02/12] ARM: dts: Add dra7 iodelay configuration
In-Reply-To: <20170616115439.8508-1-kishon@ti.com>
References: <20170616115439.8508-1-kishon@ti.com>
Message-ID: <20170616115439.8508-3-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tony Lindgren <tony@atomide.com>

Add dra7 iodelay configuration.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi       | 8 ++++++++
 include/dt-bindings/pinctrl/dra.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c09a91e77f53..b9b8b4b5143a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -418,6 +418,14 @@
 			reg = <0x40d00000 0x100>;
 		};
 
+		dra7_iodelay_core: padconf at 4844a000 {
+			compatible = "ti,dra7-iodelay";
+			reg = <0x4844a000 0x0d1c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pinctrl-cells = <2>;
+		};
+
 		sdma: dma-controller at 4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
index 5c75e80915fc..18ec5df5a581 100644
--- a/include/dt-bindings/pinctrl/dra.h
+++ b/include/dt-bindings/pinctrl/dra.h
@@ -73,5 +73,8 @@
  */
 #define DRA7XX_CORE_IOPAD(pa, val)	(((pa) & 0xffff) - 0x3400) (val)
 
+/* DRA7 IODELAY configuration parameters */
+#define A_DELAY_PS(val)			((val) & 0xffff)
+#define G_DELAY_PS(val)			((val) & 0xffff)
 #endif
 
-- 
2.11.0
