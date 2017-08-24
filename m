From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 24 Aug 2017 12:52:23 +0800
Subject: [RESENT PATCH v7 3/7] arm64: dts: rockchip: Update rt5514 devices'
 compatible for Gru
In-Reply-To: <20170824045227.15504-1-jeffy.chen@rock-chips.com>
References: <20170824045227.15504-1-jeffy.chen@rock-chips.com>
Message-ID: <20170824045227.15504-4-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the rt5514 i2c driver and rt5514 spi driver are using the same
compatible string.

Add additional unused compatible strings to identify them for Gru
boards.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 5772c52fbfd3..50fb11ad9f17 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -611,7 +611,7 @@ ap_i2c_mic: &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 
 	headsetcodec: rt5514 at 57 {
-		compatible = "realtek,rt5514";
+		compatible = "realtek,rt5514", "realtek,rt5514-i2c";
 		reg = <0x57>;
 		realtek,dmic-init-delay-ms = <20>;
 	};
@@ -820,7 +820,7 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 
 	wacky_spi_audio: spi2 at 0 {
-		compatible = "realtek,rt5514";
+		compatible = "realtek,rt5514", "realtek,rt5514-spi";
 		reg = <0>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
