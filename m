From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 29 Sep 2016 02:17:10 +0800
Subject: [PATCH v14 2/9] clocksource/drivers/arm_arch_timer: Add a new enum
 for spi type
In-Reply-To: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1475086637-1914-3-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patch add a new enum "spi_nr" and use it in the driver.
Just for code's readability, no functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 include/clocksource/arm_arch_timer.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aea6c10..059f7fb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -861,9 +861,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	}
 
 	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, 1);
+		irq = irq_of_parse_and_map(best_frame, VIRT_SPI);
 	else
-		irq = irq_of_parse_and_map(best_frame, 0);
+		irq = irq_of_parse_and_map(best_frame, PHYS_SPI);
 
 	ret = -EINVAL;
 	if (!irq) {
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 6f06481..16dcd10 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -45,6 +45,12 @@ enum ppi_nr {
 	MAX_TIMER_PPI
 };
 
+enum spi_nr {
+	PHYS_SPI,
+	VIRT_SPI,
+	MAX_TIMER_SPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
-- 
2.7.4
