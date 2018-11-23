From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 15:18:28 +0100
Subject: [PATCH 09/12] ARM64: dts: marvell: armada-37xx: declare PCIe reset pin
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
Message-ID: <20181123141831.8214-10-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One GPIO can be muxed as PCIe reset.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 65bf774516ec..9f7e932c8144 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -295,6 +295,10 @@
 					function = "mii";
 				};
 
+				pcie_pins: pcie-pins {
+					groups = "pcie1";
+					function = "gpio";
+				};
 			};
 
 			eth0: ethernet at 30000 {
-- 
2.19.1
