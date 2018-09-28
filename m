From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:20:16 +0200
Subject: [PATCH 05/14] arm64: dts: renesas: gen3: use 400kHz for I2C DVFS bus
In-Reply-To: <cover.1538125184.git.horms+renesas@verge.net.au>
References: <cover.1538125184.git.horms+renesas@verge.net.au>
Message-ID: <11a33f81616158c642ee4082e5688113994a56fc.1538125184.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The PMIC and EEPROM can operate at 400kHz, so use this speed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 ++
 arch/arm64/boot/dts/renesas/ulcb.dtsi            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index d298f7c9ada1..7f91ff524109 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -474,6 +474,8 @@
 &i2c_dvfs {
 	status = "okay";
 
+	clock-frequency = <400000>;
+
 	pmic: pmic at 30 {
 		pinctrl-0 = <&irq0_pins>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 7e6078508ba0..30506c5ba4e9 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -241,6 +241,8 @@
 &i2c_dvfs {
 	status = "okay";
 
+	clock-frequency = <400000>;
+
 	pmic: pmic at 30 {
 		pinctrl-0 = <&irq0_pins>;
 		pinctrl-names = "default";
-- 
2.11.0
