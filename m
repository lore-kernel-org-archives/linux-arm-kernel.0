From: brezillonboris@gmail.com (Boris BREZILLON)
Date: Thu, 27 Mar 2014 09:11:53 +0100
Subject: [PATCH] ARM: imx6/dt: add ccm dependency upon ckil,
 ckih1 and osc clocks
In-Reply-To: <5333DA13.2080505@gmail.com>
References: <5333DA13.2080505@gmail.com>
Message-ID: <1395907913-23808-1-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index cfc85be..060e94c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -62,16 +62,19 @@
 
 		ckil {
 			compatible = "fsl,imx-ckil", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
 		ckih1 {
 			compatible = "fsl,imx-ckih1", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
 		osc {
 			compatible = "fsl,imx-osc", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
 	};
@@ -489,6 +492,7 @@
 				interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 88 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
+				clocks = <&ckil &ckih1 &osc>;
 			};
 
 			anatop: anatop at 020c8000 {
-- 
1.7.9.5
