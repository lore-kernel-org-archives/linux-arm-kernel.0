From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 12 Aug 2015 18:49:19 +0530
Subject: [PATCH v9 2/4] ARM: dts: vfxxx: Add OCOTP node
In-Reply-To: <cover.1439384645.git.maitysanchayan@gmail.com>
References: <cover.1439384645.git.maitysanchayan@gmail.com>
Message-ID: <e633124a9b343d89742d6ece18814742189229ce.1439384645.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for the On-Chip One Time Programmable
controller (OCOTP) on the Vybrid platform.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2f4b04d..ee06c12 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -403,6 +403,15 @@
 				status = "disabled";
 			};
 
+			ocotp: ocotp at 400a5000 {
+				compatible = "fsl,vf610-ocotp";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x400a5000 0xCF0>;
+				clocks = <&clks VF610_CLK_OCOTP>;
+				clock-names = "ocotp";
+			};
+
 			snvs0: snvs at 400a7000 {
 			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
 				#address-cells = <1>;
-- 
2.5.0
