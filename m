From: stefan@agner.ch (Stefan Agner)
Date: Mon, 22 Sep 2014 19:09:22 +0200
Subject: [PATCH 1/9] ARM: dts: vf610: Add system reset controller (SRC)
In-Reply-To: <cover.1411404079.git.stefan@agner.ch>
References: <cover.1411404079.git.stefan@agner.ch>
Message-ID: <2ca1cf3732a00512fa19b6118f9fb30aba014deb.1411404079.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree property for system reset controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 3a6840c..122a64956 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -366,6 +366,13 @@
 				reg = <0x40034800 0x200>;
 				clocks = <&clks VF610_CLK_USBC0>;
 			};
+
+			src: src at 4006e000 {
+				compatible = "fsl,vf610-src";
+				reg = <0x4006e000 0x1000>;
+				interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+				#reset-cells = <0>;
+			};
 		};
 
 		aips1: aips-bus at 40080000 {
-- 
2.1.0
