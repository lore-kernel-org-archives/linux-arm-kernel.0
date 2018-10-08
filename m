From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  8 Oct 2018 12:56:41 +0200
Subject: [PATCH] ARM: dts: socfgpa: remove ethernet aliases from dtsi
Message-ID: <20181008105641.11505-1-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all boards use two ethernet devices and/or use them in different
order. As almost all in-tree boards already define their own ethernet
aliases, remove them from the dtsi and add the aliases to the two boards,
that are missing their own definition.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi                    | 2 --
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 4 ++++
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts   | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b38f8c240558..068aefa15391 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -22,8 +22,6 @@
 	#size-cells = <1>;
 
 	aliases {
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		timer0 = &timer0;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
index b280e6494193..48821bcd3eb0 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -20,6 +20,10 @@
 	model = "Terasic DE-0(Atlas)";
 	compatible = "terasic,de0-atlas", "altr,socfpga-cyclone5", "altr,socfpga";
 
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
 	chosen {
 		bootargs = "earlyprintk";
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index 53bf99eef66d..d0aede5ed558 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -21,6 +21,10 @@
 	model = "EBV SOCrates";
 	compatible = "ebv,socrates", "altr,socfpga-cyclone5", "altr,socfpga";
 
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
 	chosen {
 		bootargs = "console=ttyS0,115200";
 	};
-- 
2.19.0
