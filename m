From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 15 Jun 2018 09:41:29 +0200
Subject: [PATCH v2] ARM: dts: imx6sx: fix irq for pcie bridge
Message-ID: <20180615074129.16931-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the correct IRQ line for the MSI controller in the PCIe host
controller. Apparently a different IRQ line is used compared to other
i.MX6 variants. Without this change MSI IRQs aren't properly propagated
to the upstream interrupt controller.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 49c7205b8db8..77fdad65e2bb 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1351,7 +1351,7 @@
 			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
 				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-- 
2.17.1
