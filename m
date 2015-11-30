From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 30 Nov 2015 18:00:10 +0100
Subject: [PATCH 1/2] ARM: imx6: remove config space from PCIe controller
 ranges property
Message-ID: <1448902811-11399-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has been moved to the reg property where it belongs for quite some
time. The range has been unused by the kernel since then and with kernel
4.4 it's flagged as an unparsable range, as it does not comply to the
PCI ranges DT binding. Fix this by removing the superfluous range.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2b6cc8bf3c5c..a5a731519d9e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -173,8 +173,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000 /* configuration space */
-				  0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
+			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.6.2
