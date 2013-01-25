From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 24 Jan 2013 19:00:30 -0600
Subject: [PATCHv1 for soc 2/5] arm: socfpga: Add clock entries to socfpga.dtsi
In-Reply-To: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
Message-ID: <1359075633-13502-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Pavel Machek <pavel@denx.de>
---
 arch/arm/boot/dts/socfpga.dtsi |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 936d230..688729f 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -78,6 +78,43 @@
 			};
 		};
 
+		clkmgr at ffd04000 {
+			compatible = "altr, clk-mgr";
+			reg = <0xffd04000 0x1000>;
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				osc1: oscillator {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <50000000>;
+				};
+
+				mainpll: mainpll {
+					#clock-cells = <0>;
+					compatible = "altr,main-pll-clock";
+					clocks = <&osc1>;
+					reg = <0x40>;
+				};
+
+				perpll: perpll {
+					#clock-cells = <0>;
+					compatible = "altr,per-pll-clock";
+					clocks = <&osc1>;
+					reg = <0x80>;
+				};
+
+				sdrampll: sdrampll {
+					#clock-cells = <0>;
+					compatible = "altr,sdram-pll-clock";
+					clocks = <&osc1>;
+					reg = <0xC0>;
+				};
+			};
+		};
+
 		gmac0: stmmac at ff700000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 			reg = <0xff700000 0x2000>;
-- 
1.7.9.5
