From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 2 Apr 2015 23:39:53 -0500
Subject: [PATCH 2/7] ARM: socfpga: disable the sdmmc,
 and uart nodes in the base arria10
In-Reply-To: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
References: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1428035998-27542-3-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add status = "disabled" in the base DTSI for Arria10.  The SDMMC and uart
nodes should be enabled in the appropriate board file.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 69d616a..d843609 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -268,6 +268,7 @@
 			reg = <0xff808000 0x1000>;
 			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
 			fifo-depth = <0x400>;
+			status = "disabled";
 		};
 
 		ocram: sram at ffe00000 {
@@ -324,6 +325,7 @@
 			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			status = "disabled";
 		};
 
 		uart1: serial1 at ffc02100 {
@@ -332,6 +334,7 @@
 			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			status = "disabled";
 		};
 
 		usbphy0: usbphy at 0 {
-- 
2.2.1
