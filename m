From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu,  6 Sep 2012 16:06:18 +0300
Subject: [PATCH 2/2] ARM/dts: omap4-panda: Enable GPO functionality for twl6040
In-Reply-To: <1346936778-18303-1-git-send-email-peter.ujfalusi@ti.com>
References: <1346936778-18303-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346936778-18303-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed properties for twl6040 so the GPO functionality can be used
by other drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index d28cdc4..ed5ebdd 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -71,6 +71,9 @@
 
 	twl6040: twl at 4b {
 		compatible = "ti,twl6040";
+		gpio-controller;
+		#gpio-cells = <1>;
+
 		reg = <0x4b>;
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
-- 
1.7.12
