From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed,  6 Sep 2017 10:50:10 +0800
Subject: [RESENT PATCH v9 2/2] arm64: dts: rockchip: Update rt5514 devices'
 compatible for Gru
In-Reply-To: <20170906025010.10750-1-jeffy.chen@rock-chips.com>
References: <20170906025010.10750-1-jeffy.chen@rock-chips.com>
Message-ID: <20170906025010.10750-2-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the rt5514 i2c driver and rt5514 spi driver are using the same
compatible string.

Add additional compatible strings to identify them for Gru boards.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v9: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 199a5118b20d..a86afbf09333 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -610,7 +610,7 @@ ap_i2c_mic: &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 
 	headsetcodec: rt5514 at 57 {
-		compatible = "realtek,rt5514";
+		compatible = "realtek,rt5514", "realtek,rt5514-i2c";
 		reg = <0x57>;
 		realtek,dmic-init-delay-ms = <20>;
 	};
@@ -819,7 +819,7 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 
 	wacky_spi_audio: spi2 at 0 {
-		compatible = "realtek,rt5514";
+		compatible = "realtek,rt5514", "realtek,rt5514-spi";
 		reg = <0>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
