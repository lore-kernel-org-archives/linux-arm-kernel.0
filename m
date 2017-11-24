From: otavio@ossystems.com.br (Otavio Salvador)
Date: Fri, 24 Nov 2017 15:00:04 -0200
Subject: [PATCH v2] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
Message-ID: <20171124170004.31133-1-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the partitions definition for the SPI NOR to provide
backward compatibility with the documented[1] layout used with
Boundary Devices BSP.

1. https://boundarydevices.com/boot-flash-access-linux/

It exports to Linux:

 mtd0: bootloader
 mtd1: env
 mtd2: splash

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2:
 - rework labels (Fabio Estevam)
 - add read-only flags (Fabio Estevam)

 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 4bdf29169d2a..28545412577a 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -276,6 +276,26 @@
 		compatible = "sst,sst25vf016b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "bootloader";
+			reg = <0x0 0xc0000>;
+			read-only;
+		};
+
+		partition at c0000 {
+			label = "env";
+			reg = <0xc0000 0x2000>;
+			read-only;
+		};
+
+		partition at c2000 {
+			label = "splash";
+			reg = <0xc2000 0x13e000>;
+			read-only;
+		};
 	};
 };
 
-- 
2.15.0
