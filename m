From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 17 Feb 2014 12:27:45 +0100
Subject: [PATCH 2/2] ARM: DTS: OMAP4: Add gpmc_fck clock node
In-Reply-To: <1392636465-31459-1-git-send-email-florian.vaussard@epfl.ch>
References: <1392636465-31459-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1392636465-31459-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the gpmc_fck clock, derived from l3_ick, and reference it from
the GPMC node to get it correctly working.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap4.dtsi           | 2 ++
 arch/arm/boot/dts/omap44xx-clocks.dtsi | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..8a0cc71 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -275,6 +275,8 @@
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
 			ti,no-idle-on-init;
+			clocks = <&gpmc_fck>;
+			clock-names = "fck";
 		};
 
 		uart1: serial at 4806a000 {
diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index c821ff5..ae2c441 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -1036,6 +1036,12 @@
 		ti,index-power-of-two;
 	};
 
+	gpmc_fck: gpmc_fck {
+		#clock-cells = <0>;
+		compatible = "ti,clkdm-gate-clock";
+		clocks = <&l3_div_ck>;
+	};
+
 	gpio2_dbclk: gpio2_dbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-- 
1.8.1.2
