From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2015 10:35:30 -0800
Subject: [PATCH] ARM: dts: Fix UART wakeirq for omap4 duovero parlor
Message-ID: <1450463730-5973-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like we're missing the wakeirq for the console uart for
duovero parlor. Let's add that as without it console acess just
hangs with PM enabled.

Cc: Arun Bharadwaj <arun@gumstix.com>
Cc: Ash Charles <ash@gumstix.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -189,3 +189,7 @@
 	};
 };
 
+&uart3 {
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
+};
-- 
2.6.2
