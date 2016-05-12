From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 12 May 2016 12:38:51 +0000
Subject: [PATCH 3/4] ARM: dts: bcm2835: add the bcm2835-sdram-controller to
 the dt
In-Reply-To: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463056732-5607-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the bcm2835 sdram controller to the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 8aaf193..9db9d97 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -22,6 +22,12 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		memory-controller at 7e002000 {
+			compatible = "brcm,bcm2835-sdram";
+			reg = <0x7e002000 0x58>, <0x7e002800 0x58>;
+			clocks = <&clocks BCM2835_CLOCK_SDRAM>;
+		};
+
 		timer at 7e003000 {
 			compatible = "brcm,bcm2835-system-timer";
 			reg = <0x7e003000 0x1000>;
-- 
2.1.4
