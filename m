From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 28 Jan 2016 16:33:26 +0800
Subject: [PATCH] dts/ls1021a: add the DTS for QSPI support
Message-ID: <1453970006-46509-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
Add in v1:
Can merge, but the function depend on the patch:
https://patchwork.kernel.org/patch/8118251/

mtd: spi-nor: fsl-quadspi: add support for ls1021a

LS1021a also support Freescale Quad SPI controller.
Add fsl-quadspi support for ls1021a chip and make SPI_FSL_QUADSPI
selectable for LS1021A SOC hardwares.

---
 arch/arm/boot/dts/ls1021a.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9430a99..c764fa5 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -252,6 +252,21 @@
 			status = "disabled";
 		};
 
+		qspi: quadspi at 1550000 {
+			compatible = "fsl,ls1021a-qspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x1550000 0x0 0x10000>,
+				<0x0 0x40000000 0x0 0x4000000>;
+			reg-names = "QuadSPI", "QuadSPI-memory";
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "qspi_en", "qspi";
+			clocks = <&platform_clk 1>, <&platform_clk 1>;
+			big-endian;
+			amba-base = <0x40000000>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at 2180000 {
 			compatible = "fsl,vf610-i2c";
 			#address-cells = <1>;
-- 
2.1.0.27.g96db324
