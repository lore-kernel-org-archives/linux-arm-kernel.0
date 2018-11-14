From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 14 Nov 2018 18:52:41 +0100
Subject: [PATCH v4 5/6] arm64: dts: imx8mq: add watchdog devices
In-Reply-To: <20181114175242.12468-1-l.stach@pengutronix.de>
References: <20181114175242.12468-1-l.stach@pengutronix.de>
Message-ID: <20181114175242.12468-5-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Baruch Siach <baruch@tkos.co.il>

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v4:
 - added patch to series
 - changes node name to watchdog@
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 055b7c80bb77..ee178932ae12 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -228,6 +228,30 @@
 				              "clk_ext1", "clk_ext2",
 				              "clk_ext3", "clk_ext4";
 			};
+
+			wdog1: watchdog at 30280000 {
+				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg = <0x30280000 0x10000>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_WDOG1_ROOT>;
+				status = "disabled";
+			};
+
+			wdog2: watchdog at 30290000 {
+				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg = <0x30290000 0x10000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_WDOG2_ROOT>;
+				status = "disabled";
+			};
+
+			wdog3: watchdog at 302a0000 {
+				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg = <0x302a0000 0x10000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_WDOG3_ROOT>;
+				status = "disabled";
+			};
 		};
 
 		bus at 30400000 { /* AIPS2 */
-- 
2.19.1
