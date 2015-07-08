From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed,  8 Jul 2015 16:21:16 -0400
Subject: [PATCH v1 2/7] ARM: dts: vfxxx: Include support for qspi1
 functionality.
In-Reply-To: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <1436386881-28088-3-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit extends the existing Vybrid QSPI devicetree implementation
to also describe the qspi1 functional block.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vfxxx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 089a263..9554f3d 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -489,6 +489,19 @@
 				status = "disabled";
 			};
 
+			qspi1: quadspi at 400c4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,vf610-qspi";
+				reg = <0x400c4000 0x1000>, <0x50000000 0x10000000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks VF610_CLK_QSPI1_EN>,
+					<&clks VF610_CLK_QSPI1>;
+				clock-names = "qspi_en", "qspi";
+				status = "disabled";
+			};
+
 			fec0: ethernet at 400d0000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d0000 0x1000>;
-- 
2.3.6
