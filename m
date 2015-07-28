From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 28 Jul 2015 14:03:30 +0200
Subject: [PATCH 3/4] ARM: dts: rockchip: Add SPDIF transceiver for RK3188
In-Reply-To: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1438085011-16577-4-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SPDIF transceiver controller and pin for RK3188

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/boot/dts/rk3188.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 0f23aed..43e9bdf 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -121,6 +121,22 @@
 		status = "disabled";
 	};
 
+	spdif: spdif at 0x1011e000 {
+		compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
+		reg = <0x1011e000 0x2000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		dmas = <&dmac1_s 8>;
+		dma-names = "tx";
+		clock-names = "spdif_hclk", "spdif_clk";
+		clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
+		status = "disabled";
+		#sound-dai-cells = <0>;
+	};
+
 	cru: clock-controller at 20000000 {
 		compatible = "rockchip,rk3188-cru";
 		reg = <0x20000000 0x1000>;
@@ -462,6 +478,12 @@
 						<RK_GPIO1 21 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
+
+		spdif {
+			spdif_tx: spdif-tx {
+				rockchip,pins = <RK_GPIO1 14 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
 	};
 };
 
-- 
2.4.6
