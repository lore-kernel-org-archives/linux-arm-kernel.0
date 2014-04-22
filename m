From: s-anna@ti.com (Suman Anna)
Date: Tue, 22 Apr 2014 17:23:35 -0500
Subject: [PATCH 1/3] ARM: dts: OMAP5: Add mailbox dt node to fix boot warning
In-Reply-To: <1398205417-1575-1-git-send-email-s-anna@ti.com>
References: <1398205417-1575-1-git-send-email-s-anna@ti.com>
Message-ID: <1398205417-1575-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the mailbox device DT node for OMAP5 SoC. The OMAP5 mailbox
IP is identical to that used in OMAP4.

The OMAP5 hwmod data no longer publishes the module address space,
so this patch fixes the WARN_ON backtrace associated with the
following trace during the kernel boot:
"omap_hwmod: mailbox: doesn't have mpu register target base".

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 6f3de22..e8988bb 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -630,6 +630,13 @@
 			status = "disabled";
 		};
 
+		mailbox: mailbox at 4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mailbox";
+		};
+
 		timer1: timer at 4ae18000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x4ae18000 0x80>;
-- 
1.9.2
