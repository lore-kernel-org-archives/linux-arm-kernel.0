From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 14 Jun 2018 11:45:27 +0200
Subject: [PATCH v1] ARM: dts: imx6sx: fix irq for pcie bridge
Message-ID: <20180614094527.25905-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch MSI interrupts are not routed from Intel
i350 PCIe adapter.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
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
