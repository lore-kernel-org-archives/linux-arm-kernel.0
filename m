From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Sep 2012 11:49:33 +0200
Subject: [PATCH] ARM i.MX dtsi: Add default bus-width property for esdhc
 controller
Message-ID: <1348566573-15210-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/mmc/mmc.txt bus-width
is a mandatory property. While this is currently enforced nowhere, it's
a good habit to just add the property now to allow to add common helper
functionality for the mmc property parsing later.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

I will add the same property to the i.MX25 devicetree aswell.

 arch/arm/boot/dts/imx51.dtsi |    3 +++
 arch/arm/boot/dts/imx53.dtsi |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi |    4 ++++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index aba28dc..31ec29a 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -87,6 +87,7 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70008000 0x4000>;
 					interrupts = <2>;
+					bus-width = <4>;
 					status = "disabled";
 				};
 
@@ -119,6 +120,7 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70020000 0x4000>;
 					interrupts = <3>;
+					bus-width = <4>;
 					status = "disabled";
 				};
 
@@ -126,6 +128,7 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70024000 0x4000>;
 					interrupts = <4>;
+					bus-width = <4>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd37165..7573388 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -85,6 +85,7 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
+					bus-width = <4>;
 					status = "disabled";
 				};
 
@@ -92,6 +93,7 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
+					bus-width = <4>;
 					status = "disabled";
 				};
 
@@ -124,6 +126,7 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
+					bus-width = <4>;
 					status = "disabled";
 				};
 
@@ -131,6 +134,7 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
+					bus-width = <4>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index fd57079..4c245bf 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -677,6 +677,7 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <0 22 0x04>;
+				bus-width = <4>;
 				status = "disabled";
 			};
 
@@ -684,6 +685,7 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <0 23 0x04>;
+				bus-width = <4>;
 				status = "disabled";
 			};
 
@@ -691,6 +693,7 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <0 24 0x04>;
+				bus-width = <4>;
 				status = "disabled";
 			};
 
@@ -698,6 +701,7 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x0219c000 0x4000>;
 				interrupts = <0 25 0x04>;
+				bus-width = <4>;
 				status = "disabled";
 			};
 
-- 
1.7.10.4
