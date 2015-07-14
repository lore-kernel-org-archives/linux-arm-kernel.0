From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:45 +0200
Subject: [PATCH 10/17] ARM: dts: lpc18xx: add usb nodes
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-11-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the two USB EHCI controllers found on lpc18xx.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index be154749bf56..c17b82cc2d4c 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -78,6 +78,23 @@
 			status = "disabled";
 		};
 
+		usb0: ehci at 40006100 {
+			compatible = "nxp,lpc1850-ehci", "generic-ehci";
+			reg = <0x40006100 0x100>;
+			interrupts = <8>;
+			clocks = <&ccu1 CLK_CPU_USB0>;
+			has-transaction-translator;
+			status = "disabled";
+		};
+
+		usb1: ehci at 40007100 {
+			compatible = "nxp,lpc1850-ehci", "generic-ehci";
+			reg = <0x40007100 0x100>;
+			interrupts = <9>;
+			clocks = <&ccu1 CLK_CPU_USB1>;
+			status = "disabled";
+		};
+
 		mac: ethernet at 40010000 {
 			compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
 			reg = <0x40010000 0x2000>;
-- 
1.8.0
