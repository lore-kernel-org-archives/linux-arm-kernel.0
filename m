From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon,  3 Sep 2018 16:08:37 +0200
Subject: [PATCH v2 2/5] arm64: dts: fsl: ls1046a: disable the flash controller
 by default
In-Reply-To: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
References: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
Message-ID: <20180903140840.23648-2-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the Integrated Flash Controller status to disabled so each board has
the option to enable it. All the existing users have status = "okay" so
there is no functional change.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index ef83786b8b90..2d8122019cd8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -200,6 +200,7 @@
 			reg = <0x0 0x1530000 0x0 0x10000>;
 			big-endian;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		qspi: quadspi at 1550000 {
-- 
2.19.0.rc1
