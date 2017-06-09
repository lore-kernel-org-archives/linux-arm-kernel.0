From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  9 Jun 2017 15:59:33 +0800
Subject: [PATCH v1 2/2] ARM: dts: rk322x: add spdif node
In-Reply-To: <1496995173-63532-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1496995173-63532-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1496995173-63532-3-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add spdif node for rk322x.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

---

 arch/arm/boot/dts/rk322x.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 48a0c1c..56f0842 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -168,6 +168,20 @@
 		status = "disabled";
 	};
 
+	spdif: spdif at 100d0000 {
+		compatible = "rockchip,rk3228-spdif";
+		reg = <0x100d0000 0x1000>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF_8CH>;
+		clock-names = "mclk", "hclk";
+		dmas = <&pdma 10>;
+		#dma-cells = <1>;
+		dma-names = "tx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		status = "disabled";
+	};
+
 	i2s2: i2s2 at 100e0000 {
 		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
 		reg = <0x100e0000 0x4000>;
@@ -651,6 +665,12 @@
 			};
 		};
 
+		spdif {
+			spdif_tx: spdif-tx {
+				rockchip,pins = <3 31 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		tsadc {
 			otp_gpio: otp-gpio {
 				rockchip,pins = <0 24 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
1.9.1
