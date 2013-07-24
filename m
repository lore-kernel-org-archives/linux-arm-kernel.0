From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 24 Jul 2013 17:18:53 +0100
Subject: [PATCH 3/3] ARM: arch_timer: Add missing include for of_* functions
In-Reply-To: <1374682733-7416-1-git-send-email-jonathan.austin@arm.com>
References: <1374682733-7416-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1374682733-7416-4-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch timer code uses a bunch of of_* functions that are defined in
linux/of.h. Currently this header is not included but the functions are
available elsewise.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ffadd83..857a196 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -15,6 +15,7 @@
 #include <linux/cpu.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
 
-- 
1.7.9.5
