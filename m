From: dev@lynxeye.de (Lucas Stach)
Date: Tue, 22 Jan 2013 22:46:07 +0100
Subject: [PATCH v2 1/3] ARM: DT: tegra: move serial clock-frequency attr into
 the SoC dtsi
In-Reply-To: <1358423961-24318-1-git-send-email-dev@lynxeye.de>
References: <1358423961-24318-1-git-send-email-dev@lynxeye.de>
Message-ID: <1358891169-5939-1-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No Tegra Platform is running PLL_P at another rate than 216MHz, nor is
any using an other PLL as UART source clock. Move attribute into SoC
level dtsi file to slim down board DT files.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
v2:
- initial revision
---
 arch/arm/boot/dts/tegra20-harmony.dts   | 1 -
 arch/arm/boot/dts/tegra20-paz00.dts     | 2 --
 arch/arm/boot/dts/tegra20-seaboard.dts  | 1 -
 arch/arm/boot/dts/tegra20-tamonten.dtsi | 1 -
 arch/arm/boot/dts/tegra20-trimslice.dts | 1 -
 arch/arm/boot/dts/tegra20-ventana.dts   | 1 -
 arch/arm/boot/dts/tegra20-whistler.dts  | 1 -
 arch/arm/boot/dts/tegra20.dtsi          | 5 +++++
 8 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 54295e3..96f4ccd 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -252,7 +252,6 @@
 
 	serial at 70006300 {
 		status = "okay";
-		clock-frequency = <216000000>;
 	};
 
 	i2c at 7000c000 {
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 80d9635..7744c8b 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -244,12 +244,10 @@
 
 	serial at 70006000 {
 		status = "okay";
-		clock-frequency = <216000000>;
 	};
 
 	serial at 70006200 {
 		status = "okay";
-		clock-frequency = <216000000>;
 	};
 
 	i2c at 7000c000 {
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index d4e4ff2..0b48359 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -303,7 +303,6 @@
 
 	serial at 70006300 {
 		status = "okay";
-		clock-frequency = <216000000>;
 	};
 
 	i2c at 7000c000 {
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index a239ccd..4766aba 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -276,7 +276,6 @@
 	};
 
 	serial at 70006300 {
-		clock-frequency = <216000000>;
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 4b6c486..adf6024 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -263,7 +263,6 @@
 
 	serial at 70006000 {
 		status = "okay";
-		clock-frequency = <216000000>;
 	};
 
 	dvi_ddc: i2c at 7000c000 {
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index e3d3b29..5b15c30 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -300,7 +300,6 @@
 
 	serial at 70006300 {
 		status = "okay";
-		clock-frequency = <216000000>;
 	};
 
 	i2c at 7000c000 {
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index b8e0ee1..ea57c0f 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -255,7 +255,6 @@
 
 	serial at 70006000 {
 		status = "okay";
-		clock-frequency = <216000000>;
 	};
 
 	hdmi_ddc: i2c at 7000c400 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9c4870f..8324ef4 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -223,6 +223,7 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
+		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		status = "disabled";
 	};
@@ -232,6 +233,7 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
+		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		status = "disabled";
 	};
@@ -241,6 +243,7 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
+		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		status = "disabled";
 	};
@@ -250,6 +253,7 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
+		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		status = "disabled";
 	};
@@ -259,6 +263,7 @@
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 91 0x04>;
+		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		status = "disabled";
 	};
-- 
1.8.0.2
