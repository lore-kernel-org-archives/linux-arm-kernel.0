From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 16:07:54 -0300
Subject: [PATCH 2/2] clocksource: armada-370-xp: Add support for Armada 38x
In-Reply-To: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392059274-26965-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The Armada 38x has a 25 Mhz fixed clock. Therefore, we can model it
as compatible to the Armada XP timer for now. Nevertheless, we introduce
a new compatible string to allow future changes.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 87eda6d..9fd20b2 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -24,6 +24,8 @@
  *   * Armada 375 has a non-usable 25 Mhz fixed timer, due to hardware
  *     issues.
  *
+ *   * Armada 380 has a 25 Mhz fixed timer.
+ *
  *   * Armada XP cannot work properly without such 25 MHz fixed timer as
  *     doing otherwise leads to using a clocksource whose frequency varies
  *     when doing cpufreq frequency changes.
@@ -327,3 +329,11 @@ CLOCKSOURCE_OF_DECLARE(armada_370, "marvell,armada-370-timer",
  */
 CLOCKSOURCE_OF_DECLARE(armada_375, "marvell,armada-375-timer",
 		       armada_370_timer_init);
+
+/*
+ * Support the Armada 38x timer as identical to the Armada XP, using the
+ * available 25 MHz clock. We maintain a SoC-specific compatible string to
+ * allow to change this in the future.
+ */
+CLOCKSOURCE_OF_DECLARE(armada_380, "marvell,armada-380-timer",
+		       armada_xp_timer_init);
-- 
1.8.1.5
