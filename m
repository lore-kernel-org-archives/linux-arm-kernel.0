From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 17 Jan 2016 12:15:31 +0000
Subject: [PATCH V3 4/4] ARM: bcm2835: add bcm2835-aux-uart support to default
 DT
In-Reply-To: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org>
References: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1453032932-2512-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add bcm2835-aux-uart support to the default device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Note that this requires the aux-clock patches to be applied first
and it may also conflict with the still pending merge of the
rename of bcm2835.dtsi.
---
 arch/arm/boot/dts/bcm2835.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index b37a088..bfd42ae 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -149,6 +149,13 @@
 			status = "disabled";
 		};
 
+		uart1: serial at 7e215040 {
+		       compatible = "brcm,bcm2835-aux-uart";
+		       reg = <0x7e215040 0x40>;
+		       interrupts = <1 29>;
+		       clocks = <&aux BCM2835_AUX_CLOCK_UART>;
+		};
+
 		sdhci: sdhci at 7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
-- 
1.7.10.4
