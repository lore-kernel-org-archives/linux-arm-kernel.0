From: claudiu.manoil@freescale.com (Claudiu Manoil)
Date: Tue, 28 Jul 2015 17:43:55 +0300
Subject: [PATCH,v3 2/3] ARM: dts: ls1021a: Add the eTSEC controller nodes
In-Reply-To: <1438094636-20421-1-git-send-email-claudiu.manoil@freescale.com>
References: <20150727142816.GP12927@tiger>
 <1438094636-20421-1-git-send-email-claudiu.manoil@freescale.com>
Message-ID: <1438094636-20421-2-git-send-email-claudiu.manoil@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for all the eTSEC controllers on the
ls1021a SoC.  Second interrupt group register blocks
and their corresponding Rx/Tx/Err interrupt sources are
included as well for each eTSEC node.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
---
v2: various findings, added 2nd interrupt group;
v3: addressed findings from Shawn Guo -
    - initial patch split in soc, boards and bindings patches;
    - removed redundant all zero local-mac-address;
    - subject prefix;

 arch/arm/boot/dts/ls1021a.dtsi | 88 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 1b306c7..0638cda 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -59,6 +59,9 @@
 		serial3 = &lpuart3;
 		serial4 = &lpuart4;
 		serial5 = &lpuart5;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
 		sysclk = &sysclk;
 	};
 
@@ -391,6 +394,91 @@
 			reg = <0x0 0x2d24000 0x0 0x4000>;
 		};
 
+		enet0: ethernet at 2d10000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			fsl,magic-packet;
+			ranges;
+
+			queue-group at 2d10000 {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d10000 0x0 0x1000>;
+				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			queue-group at 2d14000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d14000 0x0 0x1000>;
+				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		enet1: ethernet at 2d50000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			ranges;
+
+			queue-group at 2d50000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d50000 0x0 0x1000>;
+				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			queue-group at 2d54000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d54000 0x0 0x1000>;
+				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		enet2: ethernet at 2d90000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			ranges;
+
+			queue-group at 2d90000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d90000 0x0 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			queue-group at 2d94000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d94000 0x0 0x1000>;
+				interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		usb at 8600000 {
 			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 			reg = <0x0 0x8600000 0x0 0x1000>;
-- 
1.7.11.7
