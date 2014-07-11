From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 Jul 2014 16:44:36 -0500
Subject: [PATCHv2 03/10] ARM: dts: AM33xx: Add mailbox node
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Message-ID: <1405115083-52977-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox DT node data has been added for AM33xx device.
The mailbox IP in AM33xx is similar to the version found in
OMAP4+ devices.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..3a0a161 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -347,6 +347,15 @@
 			status = "disabled";
 		};
 
+		mailbox: mailbox at 480C8000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x480C8000 0x200>;
+			interrupts = <77>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <8>;
+		};
+
 		timer1: timer at 44e31000 {
 			compatible = "ti,am335x-timer-1ms";
 			reg = <0x44e31000 0x400>;
-- 
2.0.0
