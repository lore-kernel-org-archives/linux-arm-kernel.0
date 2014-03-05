From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  5 Mar 2014 14:25:50 +0100
Subject: [PATCH v2 5/6] ARM: dts: imx6: add PCIe interrupt mapping properties
In-Reply-To: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1394025951-32438-6-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As defined by the common PCI bindings.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2: drop blank lines
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2ecb1db..c1c06d25decc 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -10,6 +10,8 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #include "skeleton.dtsi"
 
 / {
@@ -127,6 +129,12 @@
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <0 123 0x04>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
 			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
 			status = "disabled";
-- 
1.9.0
