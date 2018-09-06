From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu,  6 Sep 2018 11:02:13 +0200
Subject: [PATCH v3 2/4] ARM: dts: imx6ull: add pxp support
In-Reply-To: <20180906090215.15719-1-p.zabel@pengutronix.de>
References: <20180906090215.15719-1-p.zabel@pengutronix.de>
Message-ID: <20180906090215.15719-3-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device node for the i.MX6ULL Pixel Pipeline (PXP).

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
No changes since v2.
---
 arch/arm/boot/dts/imx6ul.dtsi  | 8 ++++++++
 arch/arm/boot/dts/imx6ull.dtsi | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 6dc0b569acdf..051d42676160 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -945,6 +945,14 @@
 				status = "disabled";
 			};
 
+			pxp: pxp at 21cc000 {
+				compatible = "fsl,imx6ul-pxp";
+				reg = <0x021cc000 0x4000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "axi";
+				clocks = <&clks IMX6UL_CLK_PXP>;
+			};
+
 			qspi: qspi at 21e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index cd1776a7015a..c0518490b58c 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -57,3 +57,9 @@
 		};
 	};
 };
+
+&pxp {
+	compatible = "fsl,imx6ull-pxp";
+	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.18.0
