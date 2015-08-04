From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue,  4 Aug 2015 13:18:18 +0200
Subject: [PATCH v2 3/4] ARM: dts: rockchip: Add SPDIF transceiver for RK3188
In-Reply-To: <1438687099-14282-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438687099-14282-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1438687099-14282-4-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SPDIF transceiver controller and pin for RK3188

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

Changes in v2:
- Sort the spdif node properties
- Drop the 0x prefix from the node name
- Rename the spdif@ node to sound@

 arch/arm/boot/dts/rk3188.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 0f23aed..abdb5bc 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -121,6 +121,22 @@
 		status = "disabled";
 	};
 
+	spdif: sound at 1011e000 {
+		compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
+		reg = <0x1011e000 0x2000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
+		clock-names = "spdif_hclk", "spdif_clk";
+		clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
+		dmas = <&dmac1_s 8>;
+		dma-names = "tx";
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		status = "disabled";
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
2.5.0
