From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 20 May 2016 15:32:02 +0530
Subject: [PATCH v3 1/4] ARM: dts: vfxxx: Add device tree node for OCOTP
In-Reply-To: <cover.1463737502.git.maitysanchayan@gmail.com>
References: <cover.1463737502.git.maitysanchayan@gmail.com>
Message-ID: <b8b03694c72f27cebf607da003ebf459d9c08f8b.1463737502.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for the OCOTP peripheral on Vybrid.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2c13ec6..0e34d44 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -520,6 +520,22 @@
 				status = "disabled";
 			};
 
+			ocotp at 400a5000 {
+				compatible = "fsl,vf610-ocotp";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x400a5000 0xCF0>;
+				clocks = <&clks VF610_CLK_OCOTP>;
+
+				ocotp_cfg0: cfg0 at 410 {
+					reg = <0x410 0x4>;
+				};
+
+				ocotp_cfg1: cfg1 at 420 {
+					reg = <0x420 0x4>;
+				};
+			};
+
 			snvs0: snvs at 400a7000 {
 			    compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
 				reg = <0x400a7000 0x2000>;
-- 
2.8.2
