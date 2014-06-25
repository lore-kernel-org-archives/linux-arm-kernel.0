From: s-anna@ti.com (Suman Anna)
Date: Tue, 24 Jun 2014 20:04:48 -0500
Subject: [PATCH 2/9] ARM: dts: AM33xx: Add mailbox node
In-Reply-To: <1403658295-54766-1-git-send-email-s-anna@ti.com>
References: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Message-ID: <1403658295-54766-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox DT node data has been added for AM33xx device.
The mailbox IP in AM33xx is similar to the version found in
OMAP4+ devices.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..1da3bcf 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -347,6 +347,13 @@
 			status = "disabled";
 		};
 
+		mailbox: mailbox at 480C8000 {
+			compatible = "ti,am3352-mailbox";
+			reg = <0x480C8000 0x200>;
+			interrupts = <77>;
+			ti,hwmods = "mailbox";
+		};
+
 		timer1: timer at 44e31000 {
 			compatible = "ti,am335x-timer-1ms";
 			reg = <0x44e31000 0x400>;
-- 
2.0.0
