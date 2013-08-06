From: s-anna@ti.com (Suman Anna)
Date: Tue, 6 Aug 2013 16:40:31 -0500
Subject: [PATCHv3 5/8] ARM: dts: OMAP5: Add mailbox dt node
Message-ID: <1375825231-18227-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the mailbox device DT node for OMAP5 SoC.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e643620..a08f1ca 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -505,6 +505,17 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox at 4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <3>;
+			ti,mbox-num-fifos = <8>;
+			ti,mbox-names = "mbox-ipu", "mbox-dsp";
+			ti,mbox-data = <0 1 0 0>, <3 2 0 0>;
+		};
+
 		timer1: timer at 4ae18000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x4ae18000 0x80>;
-- 
1.8.3.3
