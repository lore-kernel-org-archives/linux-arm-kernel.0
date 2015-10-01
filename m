From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:42 +0200
Subject: [PATCH 05/16] ARM: dts: lpc18xx: add dma to ssp0/1
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-6-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dmas entries to the two SSP peripherals on LPC18xx/43xx devices
so that DMA can be used to transfer data.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index f0d1a099507f..5b7ca7066161 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -249,6 +249,9 @@
 			interrupts = <22>;
 			clocks = <&ccu2 CLK_APB0_SSP0>, <&ccu1 CLK_CPU_SSP0>;
 			clock-names = "sspclk", "apb_pclk";
+			dmas = <&dmamux  9 0 2
+				&dmamux 10 0 2>;
+			dma-names = "rx", "tx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -326,6 +329,16 @@
 			interrupts = <23>;
 			clocks = <&ccu2 CLK_APB2_SSP1>, <&ccu1 CLK_CPU_SSP1>;
 			clock-names = "sspclk", "apb_pclk";
+			dmas = <&dmamux 11 2 2
+				&dmamux 12 2 2
+				&dmamux  3 3 2
+				&dmamux  4 3 2
+				&dmamux  5 2 2
+				&dmamux  6 2 2
+				&dmamux 13 2 2
+				&dmamux 14 2 2>;
+			dma-names = "rx", "tx", "tx", "rx",
+				    "tx", "rx", "rx", "tx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
1.8.0
