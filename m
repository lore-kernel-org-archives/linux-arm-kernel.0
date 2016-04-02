From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Sat,  2 Apr 2016 18:25:43 +0200
Subject: [PATCH v3 1/9] ARM: dts: imx7d: add lcdif support
In-Reply-To: <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
 <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1459614351-16731-2-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device node for the i.MX7 eLCDIF interface.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---

Changes v1 -> v2:
- none
Changes v2 -> v3:
- Re-order lcdif node by unit-address order

---
 arch/arm/boot/dts/imx7d.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b5a50e0..2547e16 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -651,6 +651,17 @@
 				#pwm-cells = <2>;
 				status = "disabled";
 			};
+
+			lcdif: lcdif at 30730000 {
+				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				reg = <0x30730000 0x10000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
+					<&clks IMX7D_CLK_DUMMY>,
+					<&clks IMX7D_CLK_DUMMY>;
+				clock-names = "pix", "axi", "disp_axi";
+				status = "disabled";
+			};
 		};
 
 		aips3: aips-bus at 30800000 {
-- 
2.7.0
