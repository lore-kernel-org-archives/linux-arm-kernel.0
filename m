From: s-anna@ti.com (Suman Anna)
Date: Tue, 6 Aug 2013 16:40:41 -0500
Subject: [PATCHv3 8/8] ARM: dts: AM33xx: Add mailbox node
Message-ID: <1375825241-18335-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox DT node data has been added for AM33xx device, with
information added currently for communicating with WkupM3
processor. The usr_id value in the DT node reflects the value
used for MPU like the rest of the SoCs. The driver logic will
be adjusted to account for the WkupM3 usr_id within the code.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..413dfa56 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -249,6 +249,17 @@
 			status = "disabled";
 		};
 
+		mailbox: mailbox at 480C8000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x480C8000 0x200>;
+			interrupts = <77>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <8>;
+			ti,mbox-names = "wkup_m3";
+			ti,mbox-data = <0 0 0 0>;
+		};
+
 		timer1: timer at 44e31000 {
 			compatible = "ti,am335x-timer-1ms";
 			reg = <0x44e31000 0x400>;
-- 
1.8.3.3
