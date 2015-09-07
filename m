From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  7 Sep 2015 13:51:36 +0530
Subject: [PATCH v10 2/4] ARM: dts: vfxxx: Add OCOTP node
In-Reply-To: <cover.1441609625.git.maitysanchayan@gmail.com>
References: <cover.1441609625.git.maitysanchayan@gmail.com>
Message-ID: <8db23e3773adeb05aa6764bf4666a544495a8e28.1441609625.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for the On-Chip One Time Programmable
controller (OCOTP) on the Vybrid platform.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2f4b04d..140d81e 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -403,6 +403,14 @@
 				status = "disabled";
 			};
 
+			ocotp: ocotp at 400a5000 {
+				compatible = "fsl,vf610-ocotp";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x400a5000 0xCF0>;
+				clocks = <&clks VF610_CLK_OCOTP>;
+			};
+
 			snvs0: snvs at 400a7000 {
 			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
 				#address-cells = <1>;
-- 
2.5.1
