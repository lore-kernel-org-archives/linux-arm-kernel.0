From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 16 Aug 2017 17:24:32 +0800
Subject: [PATCH] arm64: dts: rockchip: Assign mic irq to correct device for Gru
Message-ID: <20170816092432.23991-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are assigning mic irq to rt5514 i2c driver, which is wrong.
Assign it to rt5514 spi driver instead.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index d48e98b62d09..d7723a77ae03 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -612,12 +612,8 @@ ap_i2c_mic: &i2c1 {
 	headsetcodec: rt5514 at 57 {
 		compatible = "realtek,rt5514";
 		reg = <0x57>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&mic_int>;
+
 		realtek,dmic-init-delay = <20>;
-		wakeup-source;
 	};
 };
 
@@ -826,9 +822,13 @@ ap_i2c_audio: &i2c8 {
 	wacky_spi_audio: spi2 at 0 {
 		compatible = "realtek,rt5514";
 		reg = <0>;
-
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mic_int>;
 		/* May run faster once verified. */
 		spi-max-frequency = <10000000>;
+		wakeup-source;
 	};
 };
 
-- 
2.11.0
