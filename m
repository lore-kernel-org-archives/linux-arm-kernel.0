From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon, 11 May 2015 10:41:38 +0530
Subject: [RFC 1/2] ARM: dts: vfxxx: Add OCOTP node
In-Reply-To: <cover.1431319599.git.maitysanchayan@gmail.com>
References: <cover.1431319599.git.maitysanchayan@gmail.com>
Message-ID: <7bec56977e512c08403ebba9aa3141f73cdb6b3c.1431319599.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree node for the On-Chip One Time Programmable
Controller (OCOTP).

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 5857f60..a79776e 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -487,6 +487,11 @@
 				status = "disabled";
 			};
 
+			ocotp: ocotp at 400a5000 {
+			   compatible = "fsl,vf610-ocotp", "syscon";
+			   reg = <0x400a5000 0x1000>;
+			};
+
 			snvs0: snvs at 400a7000 {
 			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
 				#address-cells = <1>;
-- 
2.4.0
