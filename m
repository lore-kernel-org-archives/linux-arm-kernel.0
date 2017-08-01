From: vigneshr@ti.com (Vignesh R)
Date: Tue, 1 Aug 2017 10:24:31 +0530
Subject: [PATCH 4/7] ARM: dts: keystone-k2g: Add QSPI DT entry
In-Reply-To: <20170801045434.8733-1-vigneshr@ti.com>
References: <20170801045434.8733-1-vigneshr@ti.com>
Message-ID: <20170801045434.8733-5-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT node for Cadence QSPI IP present in 66AK2G SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index bf4d1fa30840..95327aabfaa4 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -168,5 +168,20 @@
 				#reset-cells = <2>;
 			};
 		};
+
+		qspi: qspi at 2940000 {
+			compatible = "ti,k2g-qspi", "cdns,qspi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x02940000 0x1000>,
+			      <0x24000000 0x4000000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x24000000>;
+			clocks = <&k2g_clks 0x43 0x0>;
+			power-domains = <&k2g_pds 0x43>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.13.3
