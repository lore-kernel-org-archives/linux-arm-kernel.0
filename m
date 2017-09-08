From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 15:46:37 -0500
Subject: [PATCH 2/3] ARM: dts: keystone-k2g: Add SPI nodes
In-Reply-To: <20170908204638.13149-1-fcooper@ti.com>
References: <20170908204638.13149-1-fcooper@ti.com>
Message-ID: <20170908204638.13149-3-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

Add nodes for the various SPI instances.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 826b286..9f9e9e1 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -343,5 +343,53 @@
 			clock-names = "fck", "mmchsdb_fck";
 			status = "disabled";
 		};
+
+		spi0: spi at 21805400 {
+			compatible = "ti,keystone-spi";
+			reg = <0x21805400 0x200>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <0>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			power-domains = <&k2g_pds 0x0010>;
+			clocks = <&k2g_clks 0x0010 0>;
+		};
+
+		spi1: spi at 21805800 {
+			compatible = "ti,keystone-spi";
+			reg = <0x21805800 0x200>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <0>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			power-domains = <&k2g_pds 0x0011>;
+			clocks = <&k2g_clks 0x0011 0>;
+		};
+
+		spi2: spi at 21805c00 {
+			compatible = "ti,keystone-spi";
+			reg = <0x21805C00 0x200>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <0>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			power-domains = <&k2g_pds 0x0012>;
+			clocks = <&k2g_clks 0x0012 0>;
+		};
+
+		spi3: spi at 21806000 {
+			compatible = "ti,keystone-spi";
+			reg = <0x21806000 0x200>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <0>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			power-domains = <&k2g_pds 0x0013>;
+			clocks = <&k2g_clks 0x0013 0>;
+		};
 	};
 };
-- 
2.9.4.dirty
