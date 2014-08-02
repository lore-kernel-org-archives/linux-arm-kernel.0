From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat,  2 Aug 2014 02:52:23 +0200
Subject: [PATCH v6 03/10] ARM: dts: Prepare node labels for exynos5250
In-Reply-To: <1406940750-15880-1-git-send-email-afaerber@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
Message-ID: <1406940750-15880-4-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows them to be extended by reference.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v6: Split off from Snow/SMDK cleanups (Doug Anderson)

 arch/arm/boot/dts/exynos5250.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 834fb5a5306f..cf94aeaeaa84 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -215,7 +215,7 @@
 		clock-names = "fimg2d";
 	};
 
-	codec at 11000000 {
+	mfc: codec at 11000000 {
 		compatible = "samsung,mfc-v6";
 		reg = <0x11000000 0x10000>;
 		interrupts = <0 96 0>;
@@ -224,7 +224,7 @@
 		clock-names = "mfc";
 	};
 
-	rtc at 101E0000 {
+	rtc: rtc at 101E0000 {
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
 		status = "disabled";
@@ -238,27 +238,27 @@
 		clock-names = "tmu_apbif";
 	};
 
-	serial at 12C00000 {
+	uart0: serial at 12C00000 {
 		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
-	serial at 12C10000 {
+	uart1: serial at 12C10000 {
 		clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
-	serial at 12C20000 {
+	uart2: serial at 12C20000 {
 		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
-	serial at 12C30000 {
+	uart3: serial at 12C30000 {
 		clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
-	sata at 122F0000 {
+	sata: sata at 122F0000 {
 		compatible = "snps,dwc-ahci";
 		samsung,sata-freq = <66>;
 		reg = <0x122F0000 0x1ff>;
@@ -570,7 +570,7 @@
 		#phy-cells = <1>;
 	};
 
-	usb at 12110000 {
+	ehci: usb at 12110000 {
 		compatible = "samsung,exynos4210-ehci";
 		reg = <0x12110000 0x100>;
 		interrupts = <0 71 0>;
@@ -585,7 +585,7 @@
 		};
 	};
 
-	usb at 12120000 {
+	ohci: usb at 12120000 {
 		compatible = "samsung,exynos4210-ohci";
 		reg = <0x12120000 0x100>;
 		interrupts = <0 71 0>;
@@ -722,7 +722,7 @@
 		clock-names = "gscl";
 	};
 
-	hdmi {
+	hdmi: hdmi {
 		compatible = "samsung,exynos4212-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
@@ -748,14 +748,14 @@
 		#phy-cells = <0>;
 	};
 
-	dp-controller at 145B0000 {
+	dp: dp-controller at 145B0000 {
 		clocks = <&clock CLK_DP>;
 		clock-names = "dp";
 		phys = <&dp_phy>;
 		phy-names = "dp";
 	};
 
-	fimd at 14400000 {
+	fimd: fimd at 14400000 {
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 	};
-- 
1.9.3
