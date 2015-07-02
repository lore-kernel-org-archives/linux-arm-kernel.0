From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu,  2 Jul 2015 19:56:43 +0200
Subject: [PATCH v2 4/4] leds: leds-ns2: depends on MACH_ARMADA_370
In-Reply-To: <1435859803-19583-1-git-send-email-simon.guinot@sequanux.org>
References: <1435859803-19583-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1435859803-19583-5-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The leds-ns2 driver is also used by the n090401 board (Seagate NAS
4-Bay), which is based on the Marvell Armada-370 SoC.

Then this patch allows to select the leds-ns2 driver if MACH_ARMADA_370
is enabled. Additionally, this also updates the Kconfig help message.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
---
 drivers/leds/Kconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 966b9605f5f0..68fd6b2b12be 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -431,12 +431,16 @@ config LEDS_MC13783
 config LEDS_NS2
 	tristate "LED support for Network Space v2 GPIO LEDs"
 	depends on LEDS_CLASS
-	depends on MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD || MACH_ARMADA_370
 	default y
 	help
-	  This option enable support for the dual-GPIO LED found on the
-	  Network Space v2 board (and parents). This include Internet Space v2,
-	  Network Space (Max) v2 and d2 Network v2 boards.
+	  This option enables support for the dual-GPIO LEDs found on the
+	  following LaCie/Seagate boards:
+
+		Network Space v2 (and parents: Max, Mini)
+		Internet Space v2
+		d2 Network v2
+		n090401 (Seagate NAS 4-Bay)
 
 config LEDS_NETXBIG
 	tristate "LED support for Big Network series LEDs"
-- 
2.1.4
