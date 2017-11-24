From: otavio@ossystems.com.br (Otavio Salvador)
Date: Fri, 24 Nov 2017 09:21:51 -0200
Subject: [PATCH] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
Message-ID: <20171124112151.2758-1-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the partitions definition for the SPI NOR to provide
backward compatibility with the documented[1] layout used with
Boundary Devices BSP.

1. https://boundarydevices.com/boot-flash-access-linux/

It exports to Linux:

 mtd0: U-Boot
 mtd1: U-Boot Environment
 mtd2: Bootsplash

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 4bdf29169d2a..f8b267875e1c 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -276,6 +276,23 @@
 		compatible = "sst,sst25vf016b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "U-Boot";
+			reg = <0x0 0xc0000>;
+		};
+
+		partition at c0000 {
+			label = "U-Boot Environment";
+			reg = <0xc0000 0x2000>;
+		};
+
+		partition at c2000 {
+			label = "Bootsplash";
+			reg = <0xc2000 0x13e000>;
+		};
 	};
 };
 
-- 
2.15.0
