From: joerg.krause@embedded.rocks (=?UTF-8?q?J=C3=B6rg=20Krause?=)
Date: Sun, 25 Feb 2018 00:06:05 +0100
Subject: [PATCH] ARM: dts: imx6ul: add wdog3 node
Message-ID: <20180224230605.24450-1-joerg.krause@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6UL(L) has a WDOG3 located at start address 0x021e4000 in the
AIPS-2 memory region [1].

[1] i.MX 6UltraLite Applications Processor Reference Manual, Rev. 1,
    04/2016, Table 2-3. AIPS-2 memory map, p. 166

Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>
---
 arch/arm/boot/dts/imx6ul.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 81c426e1b664..9ec0dfbbb4ad 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -931,6 +931,14 @@
 				status = "disabled";
 			};
 
+			wdog3: wdog at 21e4000 {
+				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				reg = <0x021e4000 0x4000>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_WDOG3>;
+				status = "disabled";
+			};
+
 			uart2: serial at 21e8000 {
 				compatible = "fsl,imx6ul-uart",
 					     "fsl,imx6q-uart";
-- 
2.16.2
