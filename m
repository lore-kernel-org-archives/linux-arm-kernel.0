From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu,  8 Oct 2015 15:31:17 +0200
Subject: [PATCH v4 6/8] ARM: dts: rockchip: Add SPDIF transceiver for RK3288
In-Reply-To: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1444311079-2892-7-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SPDIF transceiver controller definition and pin setup for RK3288
SoCs

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..b905cf6 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -653,6 +653,23 @@
 		status = "disabled";
 	};
 
+	spdif: sound at ff88b0000 {
+		compatible = "rockchip,rk3288-spdif", "rockchip,rk3066-spdif";
+		reg = <0xff8b0000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
+		clock-names = "hclk", "mclk";
+		clocks = <&cru HCLK_SPDIF8CH>, <&cru SCLK_SPDIF8CH>;
+		dmas = <&dmac_bus_s 3>;
+		dma-names = "tx";
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
 	i2s: i2s at ff890000 {
 		compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
 		reg = <0xff890000 0x10000>;
@@ -1334,5 +1351,11 @@
 						<4 3 3 &pcfg_pull_none>;
 			};
 		};
+
+		spdif {
+			spdif_tx: spdif-tx {
+				rockchip,pins = <RK_GPIO6 11 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
 	};
 };
-- 
2.6.1
