From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 Jul 2014 16:44:35 -0500
Subject: [PATCHv2 02/10] ARM: dts: OMAP4: Add mailbox node
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Message-ID: <1405115083-52977-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox DT node data has been added for OMAP44xx
devices.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 7e26d22..69408b5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -649,6 +649,15 @@
 			};
 		};
 
+		mailbox: mailbox at 4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <3>;
+			ti,mbox-num-fifos = <8>;
+		};
+
 		timer1: timer at 4a318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x4a318000 0x80>;
-- 
2.0.0
