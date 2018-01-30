From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 30 Jan 2018 15:18:44 +0100
Subject: [PATCH v2] ARM64: dts: marvell: armada-cp110: Add registers clock for
 SPI nodes
Message-ID: <20180130141844.18827-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the SPI controller
used on Armada 7K/8K SoCs.

This follows the changes already made in the binding documentation (as
well as in the driver) in:
'commit 92ae112e477ac412decc3fdd5c1eeb6c90c266b4 ("spi: orion: Fix clock
resource by adding an optional bus clock")'.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---

Changelog:

v1 -> v2
Add comment about the commit modifying the driver in the commit log

 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index a8af4136dbe7..0ab921861a2f 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -257,7 +257,9 @@
 			reg = <0x700600 0x50>;
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
-			clocks = <&CP110_LABEL(clk) 1 21>;
+			clock-names = "core", "axi";
+			clocks = <&CP110_LABEL(clk) 1 21>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "disabled";
 		};
 
@@ -266,7 +268,9 @@
 			reg = <0x700680 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			clocks = <&CP110_LABEL(clk) 1 21>;
+			clock-names = "core", "axi";
+			clocks = <&CP110_LABEL(clk) 1 21>,
+				 <&CP110_LABEL(clk) 1 17>;
 			status = "disabled";
 		};
 
-- 
2.15.1
