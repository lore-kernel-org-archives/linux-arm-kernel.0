From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  9 Jan 2014 13:01:09 +0800
Subject: [PATCH 2/4] ARM: dts: sirf: add lost bus_width,
 clock and status for sdhci
In-Reply-To: <1389243671-18099-1-git-send-email-21cnbao@gmail.com>
References: <1389243671-18099-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1389243671-18099-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bin Shi <Bin.Shi@csr.com>

some nodes missed bus_width, clocks and status properties, here we fix them
in prima2 and atlas6 dtsi.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    4 ++++
 arch/arm/boot/dts/prima2.dtsi |   13 +++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index f303a6c..0f1821a 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -637,6 +637,7 @@
 					reg = <0x56100000 0x100000>;
 					interrupts = <38>;
 					status = "disabled";
+					bus-width = <4>;
 					clocks = <&clks 36>;
 				};
 
@@ -646,6 +647,7 @@
 					reg = <0x56200000 0x100000>;
 					interrupts = <23>;
 					status = "disabled";
+					bus-width = <4>;
 					clocks = <&clks 37>;
 				};
 
@@ -655,6 +657,7 @@
 					reg = <0x56300000 0x100000>;
 					interrupts = <23>;
 					status = "disabled";
+					bus-width = <4>;
 					clocks = <&clks 37>;
 				};
 
@@ -664,6 +667,7 @@
 					reg = <0x56500000 0x100000>;
 					interrupts = <39>;
 					status = "disabled";
+					bus-width = <4>;
 					clocks = <&clks 38>;
 				};
 
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index de3cfa5..8cea924 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -649,6 +649,9 @@
 					compatible = "sirf,prima2-sdhc";
 					reg = <0x56000000 0x100000>;
 					interrupts = <38>;
+					status = "disabled";
+					bus-width = <8>;
+					clocks = <&clks 36>;
 				};
 
 				sd1: sdhci at 56100000 {
@@ -656,6 +659,9 @@
 					compatible = "sirf,prima2-sdhc";
 					reg = <0x56100000 0x100000>;
 					interrupts = <38>;
+					status = "disabled";
+					bus-width = <4>;
+					clocks = <&clks 36>;
 				};
 
 				sd2: sdhci at 56200000 {
@@ -663,6 +669,8 @@
 					compatible = "sirf,prima2-sdhc";
 					reg = <0x56200000 0x100000>;
 					interrupts = <23>;
+					status = "disabled";
+					clocks = <&clks 37>;
 				};
 
 				sd3: sdhci at 56300000 {
@@ -670,6 +678,8 @@
 					compatible = "sirf,prima2-sdhc";
 					reg = <0x56300000 0x100000>;
 					interrupts = <23>;
+					status = "disabled";
+					clocks = <&clks 37>;
 				};
 
 				sd4: sdhci at 56400000 {
@@ -677,6 +687,8 @@
 					compatible = "sirf,prima2-sdhc";
 					reg = <0x56400000 0x100000>;
 					interrupts = <39>;
+					status = "disabled";
+					clocks = <&clks 38>;
 				};
 
 				sd5: sdhci at 56500000 {
@@ -684,6 +696,7 @@
 					compatible = "sirf,prima2-sdhc";
 					reg = <0x56500000 0x100000>;
 					interrupts = <39>;
+					clocks = <&clks 38>;
 				};
 
 				pci-copy at 57900000 {
-- 
1.7.5.4
