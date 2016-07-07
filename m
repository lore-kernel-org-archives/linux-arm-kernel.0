From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Thu,  7 Jul 2016 12:09:27 +0530
Subject: [PATCH v4 2/5] ARM: dts: vfxxx: Add On-Chip ROM node for Vybrid
In-Reply-To: <cover.1467872014.git.maitysanchayan@gmail.com>
References: <cover.1467872014.git.maitysanchayan@gmail.com>
Message-ID: <1f0d02081aaf80c953d81fb63d75040470e06fba.1467872014.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree node for the On-Chip ROM on Vybrid.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 0e34d44..6c5222e 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -91,6 +91,11 @@
 		interrupt-parent = <&mscm_ir>;
 		ranges;
 
+		ocrom: ocrom at 00000000 {
+			compatible = "fsl,vf610-ocrom", "syscon";
+			reg = <0x00000000 0x18000>;
+		};
+
 		aips0: aips-bus at 40000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
2.9.0
