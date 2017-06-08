From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Thu, 8 Jun 2017 19:26:58 +0300
Subject: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
In-Reply-To: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
Message-ID: <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This seems to work fine with the existing imx thermal driver on both 6ul
and 6ull. It was just missing in dts.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b9d7d2d..cda5e9e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -597,6 +597,14 @@
 				fsl,anatop = <&anatop>;
 			};
 
+			tempmon: tempmon {
+				compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,tempmon = <&anatop>;
+				fsl,tempmon-data = <&ocotp>;
+				clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+			};
+
 			snvs: snvs at 020cc000 {
 				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
 				reg = <0x020cc000 0x4000>;
-- 
2.7.4
