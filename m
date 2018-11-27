From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Tue, 27 Nov 2018 14:57:21 +0000
Subject: [PATCH] ARM: dts: alpine: Correct the GIC DT node name
Message-ID: <20181127145721.7237-1-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Harmless mistake, but it's incorrect. The DT spec provides recommendations
for the node names:
"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model. If appropriate, the
name should be one of the following choices:
...
interrupt-controller"

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/alpine.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 731df7a8c4e6..533c876497ff 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -85,7 +85,7 @@
 		};
 
 		/* Interrupt Controller */
-		gic: gic at fb001000 {
+		gic: interrupt-controller at fb001000 {
 			compatible = "arm,cortex-a15-gic";
 			#interrupt-cells = <3>;
 			#size-cells = <0>;
-- 
2.17.1
