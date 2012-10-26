From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Oct 2012 13:43:03 -0500
Subject: [PATCH 1/6] ARM: highbank: disable unused sdhci and gpio in dts
In-Reply-To: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
References: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
Message-ID: <1351276988-28382-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

These peripherals are not enabled in current systems, so turn them off.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/highbank.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index 0c6fc34..28d5872 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -132,6 +132,7 @@
 			reg = <0xffe0e000 0x1000>;
 			interrupts = <0 90 4>;
 			clocks = <&eclk>;
+			status = "disabled";
 		};
 
 		memory-controller at fff00000 {
@@ -156,6 +157,7 @@
 			interrupts = <0 14 4>;
 			clocks = <&pclk>;
 			clock-names = "apb_pclk";
+			status = "disabled";
 		};
 
 		gpiof: gpio at fff31000 {
@@ -166,6 +168,7 @@
 			interrupts = <0 15 4>;
 			clocks = <&pclk>;
 			clock-names = "apb_pclk";
+			status = "disabled";
 		};
 
 		gpiog: gpio at fff32000 {
@@ -176,6 +179,7 @@
 			interrupts = <0 16 4>;
 			clocks = <&pclk>;
 			clock-names = "apb_pclk";
+			status = "disabled";
 		};
 
 		gpioh: gpio at fff33000 {
@@ -186,6 +190,7 @@
 			interrupts = <0 17 4>;
 			clocks = <&pclk>;
 			clock-names = "apb_pclk";
+			status = "disabled";
 		};
 
 		timer {
-- 
1.7.10.4
