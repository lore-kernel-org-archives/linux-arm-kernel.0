From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Jun 2016 15:23:32 +0200
Subject: [PATCH 04/10] arm64: dts: marvell: add peripherals clocks for Armada
 37xx
In-Reply-To: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465565018-14172-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two new blocks of clocks. The peripheral clocks are the source clocks
of the peripheral of the Armada 3700 SoC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e9f0b97c63d5..c55542ba0c54 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -105,6 +105,22 @@
 				status = "disabled";
 			};
 
+			nb_perih_clk: nb-periph-clk at 13000{
+				compatible = "marvell,armada-3700-periph-clock-nb";
+				reg = <0x13000 0x100>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+				<&tbg 3>, <&xtalclk>;
+				#clock-cells = <1>;
+			};
+
+			sb_perih_clk: sb-periph-clk at 13000{
+				compatible = "marvell,armada-3700-periph-clock-sb";
+				reg = <0x18000 0x100>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+				<&tbg 3>, <&xtalclk>;
+				#clock-cells = <1>;
+			};
+
 			tbg: tbg at 13200 {
 				compatible = "marvell,armada-3700-tbg-clock";
 				reg = <0x13200 0x100>;
-- 
2.5.0
