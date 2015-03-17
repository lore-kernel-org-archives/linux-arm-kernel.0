From: yao.yuan@freescale.com (Yuan Yao)
Date: Tue, 17 Mar 2015 13:28:39 +0800
Subject: [PATCH 2/2] ARM: dts: ls1021: Add qDMA node
In-Reply-To: <1426570119-8634-1-git-send-email-yao.yuan@freescale.com>
References: <1426570119-8634-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1426570119-8634-2-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 491480f..1a81b89 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -383,6 +383,22 @@
 				 <&platform_clk 1>;
 		};
 
+		qdma: qdma at 8390000 {
+			compatible = "fsl,ls1021a-qdma";
+			reg = <0x0 0x8390000 0x0 0x10000>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "qdma-controller", "qdma-queue";
+			status-sizes = <64>;
+			channels = <8>;
+			queues = <2>;
+			queue-sizes = <256 256>;
+			queue-group = <0 1>;
+			queue-weight = <0 0>;
+			default-queue = <0>;
+			big-endian;
+		};
+
 		mdio0: mdio at 2d24000 {
 			compatible = "gianfar";
 			device_type = "mdio";
-- 
2.1.0.27.g96db324
