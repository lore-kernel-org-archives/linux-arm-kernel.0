From: b56799@freescale.com (Meng Yi)
Date: Wed, 25 Nov 2015 14:46:06 +0800
Subject: [PATCH 1/2] ARM: dts: ls1021a: Add DCU dts node.
Message-ID: <1448433967-6710-1-git-send-email-b56799@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9430a99..f01c98b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -428,6 +428,16 @@
 				 <&platform_clk 1>;
 		};
 
+		dcu: dcu at 2ce0000 {
+			compatible = "fsl,ls1021a-dcu";
+			reg = <0x0 0x2ce0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 0>;
+			clock-names = "dcu";
+			big-endian;
+			status = "disabled";
+		};
+
 		mdio0: mdio at 2d24000 {
 			compatible = "gianfar";
 			device_type = "mdio";
-- 
2.1.0.27.g96db324
