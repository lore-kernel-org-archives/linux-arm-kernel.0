From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Fri,  4 Aug 2017 11:33:38 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: Add efuse device node for RK3328 SoC
In-Reply-To: <1501817618-65504-1-git-send-email-finley.xiao@rock-chips.com>
References: <1501817618-65504-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1501817618-65504-3-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an efuse node in the device tree for rk3228 SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 81fd8cb..cc8dd80 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -367,6 +367,31 @@
 		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	efuse: efuse at ff260000 {
+		compatible = "rockchip,rk3328-efuse";
+		reg = <0x0 0xff260000 0x0 0x50>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&cru SCLK_EFUSE>;
+		clock-names = "pclk_efuse";
+		rockchip,efuse-size = <0x20>;
+
+		/* Data cells */
+		efuse_id: id at 7 {
+			reg = <0x07 0x10>;
+		};
+		cpu_leakage: cpu-leakage at 17 {
+			reg = <0x17 0x1>;
+		};
+		logic_leakage: logic-leakage at 19 {
+			reg = <0x19 0x1>;
+		};
+		efuse_cpu_version: cpu-version at 1a {
+			reg = <0x1a 0x1>;
+			bits = <3 3>;
+		};
+	};
+
 	saradc: adc at ff280000 {
 		compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
 		reg = <0x0 0xff280000 0x0 0x100>;
-- 
2.7.4
