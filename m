From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 18 Sep 2013 20:49:28 +0200
Subject: [PATCH] arm: mvebu: use the main timer as clock source from DT
Message-ID: <1379530168-9359-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit:
  573145f08c2b92c45498468afbbba909f6ce6135
  clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE

replaced a call to the driver's timer initialization by a call to
clocksource_of_init(). However, it failed to select CONFIG_CLKSRC_OF.

Fix this by selecting CONFIG_CLKSRC_OF for Armada370/XP machines.
Without this change the kernel is stuck at: 'Calibrating delay loop...'.

Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 41c6946..971d796 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -26,6 +26,7 @@ config DW_APB_TIMER_OF
 
 config ARMADA_370_XP_TIMER
 	bool
+	select CLKSRC_OF
 
 config ORION_TIMER
 	select CLKSRC_OF
-- 
1.7.11.7
