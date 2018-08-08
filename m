From: atull@kernel.org (Alan Tull)
Date: Wed,  8 Aug 2018 10:42:41 -0500
Subject: [PATCH] arm64: dts: stratix10: i2c clock running out of spec
Message-ID: <20180808154241.3760-1-atull@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DesignWare I2C controller was observed running at 105.93kHz rather
than the specified 100kHz.  Adjust device tree settings to bring it
within spec (a slightly conservative 98 MHz).

Signed-off-by: Alan Tull <atull@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 6edc4fa..53cf195 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -124,6 +124,8 @@
 &i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
+	i2c-sda-falling-time-ns = <890>;  /* hcnt */
+	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
 
 	adc at 14 {
 		compatible = "lltc,ltc2497";
-- 
2.7.4
