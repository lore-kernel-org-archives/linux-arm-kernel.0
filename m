From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon, 29 Jun 2015 16:52:18 +0530
Subject: [RFC PATCH v6 2/3] ARM: dts: vfxxx: Add OCOTP node
In-Reply-To: <cover.1435574288.git.maitysanchayan@gmail.com>
References: <558A99FC.2070902@i2se.com>
 <cover.1435574288.git.maitysanchayan@gmail.com>
Message-ID: <1a30f9f95a66730292473f5bd780f058ca0afee1.1435574288.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for the On-Chip One Time Programmable
controller (OCOTP) on the Vybrid platform.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2f4b04d..05730d9 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -403,6 +403,13 @@
 				status = "disabled";
 			};
 
+			ocotp: ocotp at 400a5000 {
+				compatible = "fsl,vf610-ocotp";
+				reg = <0x400a5000 0xD00>;
+				clocks = <&clks VF610_CLK_OCOTP>;
+				clock-names = "ocotp";
+			};
+
 			snvs0: snvs at 400a7000 {
 			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
 				#address-cells = <1>;
-- 
2.4.4
