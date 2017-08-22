From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 22 Aug 2017 15:57:24 +0800
Subject: [PATCH v5 5/9] arm64: dts: rockchip: Update rt5514 devices'
 compatible for Gru
In-Reply-To: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
Message-ID: <20170822075729.8438-6-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the rt5514 i2c driver and rt5514 spi driver are using the same
compatible string.

Add additional unused compatible strings to identify them for Gru
boards.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 72717e77a0fc..c489c78b2b5b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -611,7 +611,7 @@ ap_i2c_mic: &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 
 	headsetcodec: rt5514 at 57 {
-		compatible = "realtek,rt5514";
+		compatible = "realtek,rt5514", "realtek,rt5514-i2c";
 		reg = <0x57>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
@@ -828,7 +828,7 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 
 	wacky_spi_audio: spi2 at 0 {
-		compatible = "realtek,rt5514";
+		compatible = "realtek,rt5514", "realtek,rt5514-spi";
 		reg = <0>;
 
 		/* May run faster once verified. */
-- 
2.11.0
