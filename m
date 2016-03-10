From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:43 -0800
Subject: [PATCH 02/18] ARM: dts: vf610: add GPC as new interrupt parent
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vfxxx.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 5e49fbd..909988d 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -88,7 +88,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		interrupt-parent = <&mscm_ir>;
+		interrupt-parent = <&gpc>;
 		ranges;
 
 		aips0: aips-bus at 40000000 {
@@ -475,6 +475,14 @@
 				reg = <0x4006e000 0x1000>;
 				interrupts = <96 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
+			gpc: gpc at 4006c000 {
+				compatible = "fsl,vf610-gpc";
+				reg = <0x4006c000 0x1000>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&mscm_ir>;
+			};
 		};
 
 		aips1: aips-bus at 40080000 {
-- 
2.7.2
