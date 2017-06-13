From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 13 Jun 2017 11:28:44 +0200
Subject: [PATCHv2 2/5] ARM: dts: omap4.dtsi: remove aes[12]_fck
In-Reply-To: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Message-ID: <20170613092847.16732-3-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"aes1_fck" and "aes2_fck" are controlled by hwmod. Drop clock
entries to avoid conflicts.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap44xx-clocks.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index 9573b37fbaa7..008693b0b17a 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -969,22 +969,6 @@
 		ti,max-div = <2>;
 	};
 
-	aes1_fck: aes1_fck at 15a0 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3_div_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x15a0>;
-	};
-
-	aes2_fck: aes2_fck at 15a8 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3_div_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x15a8>;
-	};
-
 	dss_sys_clk: dss_sys_clk at 1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-- 
2.11.0
