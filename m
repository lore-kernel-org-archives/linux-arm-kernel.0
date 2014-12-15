From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Dec 2014 10:56:14 +0800
Subject: [PATCH 6/6] ARM: dts: rockchip: add hdmi audio nodes
In-Reply-To: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1418612174-19784-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hdmi_audio to rk3288.dtsi, enable hdmi_audio in rk3288-evb.dts

Signed-off-by: Yakir Yang <ykk@rock-chips.com>

series-cc: Dominik Behr <dbehr@chromium.org>

---

 arch/arm/boot/dts/rk3288-evb.dtsi | 11 +++++++++++
 arch/arm/boot/dts/rk3288.dtsi     |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 3e067dd..53115d4 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -120,6 +120,17 @@
 	status = "okay";
 };
 
+&i2s {
+	status = "okay";
+	clock-names = "i2s_hclk", "i2s_clk", "i2s_clk_out";
+	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>,
+		 <&cru SCLK_I2S0_OUT>;
+};
+
+&hdmi_audio {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index fd19f00..3eeba16 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -588,6 +588,14 @@
 		interrupts = <GIC_PPI 9 0xf04>;
 	};
 
+	hdmi_audio: hdmi_audio {
+		compatible = "rockchip,rk3288-hdmi-audio";
+		cpu-of-node = <&i2s>;
+		codec-name = "dw-hdmi-audio";
+		codec-dai-name = "dw-hdmi-hifi";
+		status = "disable";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3288-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.1.2
