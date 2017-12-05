From: vigneshr@ti.com (Vignesh R)
Date: Tue, 5 Dec 2017 12:18:11 +0530
Subject: [PATCH 1/2] ARM: dts: keystone-k2g: Add UART 1 and 2 instances
In-Reply-To: <20171205064812.15758-1-vigneshr@ti.com>
References: <20171205064812.15758-1-vigneshr@ti.com>
Message-ID: <20171205064812.15758-2-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Add DT nodes for two other UART instances of 66AK2G SoC.

Also add power domain and clock domain nodes to UART 0

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index ef82c0a6e607..3c48a9f5c882 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -28,6 +28,8 @@
 
 	aliases {
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -114,7 +116,32 @@
 			reg-io-width = <4>;
 			reg = <0x02530c00 0x100>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>;
-			clock-frequency = <200000000>;
+			clocks = <&k2g_clks 0x2c 0>;
+			power-domains = <&k2g_pds 0x2c>;
+			status = "disabled";
+		};
+
+		uart1: serial at 02531000 {
+			compatible = "ti,da830-uart", "ns16550a";
+			current-speed = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			reg = <0x02531000 0x100>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&k2g_clks 0x2d 0>;
+			power-domains = <&k2g_pds 0x2d>;
+			status = "disabled";
+		};
+
+		uart2: serial at 02531400 {
+			compatible = "ti,da830-uart", "ns16550a";
+			current-speed = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			reg = <0x02531400 0x100>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&k2g_clks 0x2e 0>;
+			power-domains = <&k2g_pds 0x2e>;
 			status = "disabled";
 		};
 
-- 
2.15.0
