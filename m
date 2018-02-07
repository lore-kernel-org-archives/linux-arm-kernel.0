From: baruch@tkos.co.il (Baruch Siach)
Date: Wed,  7 Feb 2018 17:12:49 +0200
Subject: [PATCH v2 1/2] arm64: dts: fsl: imx8mq: add watchdog devices
Message-ID: <57855fb372ae19aad54c39c0e18a54cb12ed6915.1518016370.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
  * Rename nodes name prefix to 'watchdog@'
  * Add fsl,imx8mq-wdt to compatible list
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 50ed302d299a..8a83218a31e5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -250,6 +250,30 @@
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
2.15.1
