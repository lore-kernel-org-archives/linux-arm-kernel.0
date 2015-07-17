From: jianwei.wang@freescale.com (Jianwei Wang)
Date: Fri, 17 Jul 2015 18:39:02 +0800
Subject: [PATCH v10 4/5] arm/dts/ls1021a: Add DCU dts node
In-Reply-To: <1437129543-8037-1-git-send-email-jianwei.wang@freescale.com>
References: <1437129543-8037-1-git-send-email-jianwei.wang@freescale.com>
Message-ID: <1437129543-8037-4-git-send-email-jianwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianwei Wang <jianwei.wang.chn@gmail.com>

Add DCU node, DCU is a display controller of Freescale
named 2D-ACE.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
Reviewed-by: Alison Wang <alison.wang@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..6d6e3e2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -383,6 +383,16 @@
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
