From: fkan@apm.com (Feng Kan)
Date: Wed,  2 Apr 2014 09:46:08 -0700
Subject: [PATCH 1/1] arm64:dts: Add I2C DTS node entry for APM SoC X-Gene
 platform
Message-ID: <1396457168-26024-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C DTS node entry for APM SoC X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index d37d736..f90d34c 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -176,6 +176,33 @@
 				reg-names = "csr-reg";
 				clock-output-names = "eth8clk";
 			};
+
+			i2cclk: i2cclk at 17000000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x17000000 0x0 0x2000>;
+				reg-names = "csr-reg";
+				csr-offset = <0x0>;
+				csr-mask = <0x2>;
+				enable-offset = <0x10>;
+				enable-mask = <0x4>;
+				divider-offset = <0x168>;
+				divider-width = <0x5>;
+				divider-shift = <0x0>;
+				clock-output-names = "i2cclk";
+			};
+		};
+
+		i2c0: i2c at 10512000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x10512000 0x0 0x1000>;
+			interrupts = <0 0x44 0x4>;
+			#clock-cells = <1>;
+			clocks = <&i2cclk 0>;
+			bus_num = <0>;
 		};
 
 		serial0: serial at 1c020000 {
-- 
1.7.6.1
