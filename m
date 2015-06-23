From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 23 Jun 2015 19:14:56 +0530
Subject: [RFC PATCH v6 1/2] ARM: dts: vfxxx: Add OCOTP and OCROM nodes
In-Reply-To: <cover.1435066190.git.maitysanchayan@gmail.com>
References: <cover.1435066190.git.maitysanchayan@gmail.com>
Message-ID: <2214a683fcb09ef32e8b7bfbd582ebed44c37ead.1435066190.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree node for the On-Chip One Time Programmable
Controller (OCOTP) and the On-Chip ROM.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2f4b04d..6efdf49 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -57,6 +57,13 @@
 		interrupt-parent = <&mscm_ir>;
 		ranges;
 
+		ocrom: ocrom at 00000000 {
+			compatible = "fsl,vf610-ocrom";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x00000000 0x18000>;
+		};
+
 		aips0: aips-bus at 40000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
@@ -403,6 +410,17 @@
 				status = "disabled";
 			};
 
+			ocotp: ocotp at 400a5000 {
+				compatible = "fsl,vf610-ocotp";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x400a5000 0x1000>;
+
+				ocotp_cfg: cfg at 410 {
+					reg = <0x410 0x2>;
+				};
+			};
+
 			snvs0: snvs at 400a7000 {
 			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
 				#address-cells = <1>;
-- 
2.4.4
