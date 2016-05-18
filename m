From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 18 May 2016 15:40:27 +0000
Subject: [PATCH-V2 3/6] ARM: dts: bcm2835: add the bcm2835-sdram-controller to
 the dt
In-Reply-To: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
References: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463586030-2778-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the bcm2835 sdram controller to the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 2b5cbc6..177045a 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -237,6 +237,17 @@
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
 		};
+
+		memory-conroller at 7ee00000 {
+			compatible = "brcm,bcm2835-sdram";
+			reg = <0x7ee00000 0x18c>,
+			      <0x7ee06000 0x94>,
+			      <0x7ee07000 0x808>;
+			reg-names = "sdram", "aphy_csr", "dphy_csr";
+			clocks = <&clocks BCM2835_CLOCK_SDRAM>,
+				 <&clocks BCM2835_PLLD_CORE>;
+			clock-names = "low-voltage", "pll-parent";
+		};
 	};
 
 	clocks {
-- 
2.1.4
