From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:19 +0200
Subject: [PATCH 1/9] ARM: dts: lpc18xx: add usb otg phy node
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the USB OTG phy under the CREG syscon node and attach it to
the USB0 EHCI controller.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index c17b82cc2d4c..afd9d3b40eb1 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -83,6 +83,8 @@
 			reg = <0x40006100 0x100>;
 			interrupts = <8>;
 			clocks = <&ccu1 CLK_CPU_USB0>;
+			phys = <&usb0_otg_phy>;
+			phy-names = "usb";
 			has-transaction-translator;
 			status = "disabled";
 		};
@@ -109,6 +111,12 @@
 			compatible = "nxp,lpc1850-creg", "syscon", "simple-mfd";
 			reg = <0x40043000 0x1000>;
 			clocks = <&ccu1 CLK_CPU_CREG>;
+
+			usb0_otg_phy: phy at 004 {
+				compatible = "nxp,lpc1850-usb-otg-phy";
+				clocks = <&ccu1 CLK_USB0>;
+				#phy-cells = <0>;
+			};
 		};
 
 		cgu: clock-controller at 40050000 {
-- 
1.8.0
