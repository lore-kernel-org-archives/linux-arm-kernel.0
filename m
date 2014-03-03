From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon,  3 Mar 2014 17:02:15 +0100
Subject: [PATCH v2 10/11] ARM: dts: s3c64xx: Add node for display controller
In-Reply-To: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1393862536-9842-11-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree node for the display controller present on
S3C64xx SoCs.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/s3c64xx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index 4e3be4d..6fe1042 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -18,6 +18,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
+#include <dt-bindings/arm/s3c64xx-power-domains.h>
 
 / {
 	aliases {
@@ -56,6 +57,18 @@
 			#interrupt-cells = <1>;
 		};
 
+		fimd: display at 77100000 {
+			compatible = "samsung,s3c6400-fimd";
+			reg = <0x77100000 0x1000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <29>, <30>, <31>;
+			interrupt-names = "fifo", "vsync", "lcd_sys";
+			clocks = <&clocks HCLK_LCD>, <&clocks SCLK_LCD>;
+			clock-names = "fimd", "sclk_fimd";
+			power-domain = <&clocks DOMAIN_F>;
+			status = "disabled";
+		};
+
 		sdhci0: sdhci at 7c200000 {
 			compatible = "samsung,s3c6410-sdhci";
 			reg = <0x7c200000 0x100>;
-- 
1.9.0
