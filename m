From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 14 Dec 2017 15:14:27 -0200
Subject: [PATCH 2/2] ARM: dts: imx6sx: Fix PCI non-prefetchable memory range
In-Reply-To: <1513271667-1960-1-git-send-email-festevam@gmail.com>
References: <1513271667-1960-1-git-send-email-festevam@gmail.com>
Message-ID: <1513271667-1960-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The third cell of the PCI non-prefetchable memory range should be
0x08000000, so change it accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 40c6738c..f41e389 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1313,7 +1313,7 @@
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
 			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
-				  0x82000000 0 0x01000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
+				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.7.4
