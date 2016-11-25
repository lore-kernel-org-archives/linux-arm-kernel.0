From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Fri, 25 Nov 2016 16:46:10 +0800
Subject: [PATCH v17 02/15] clocksource/drivers/arm_arch_timer: Add a new enum
 for spi type
In-Reply-To: <20161125084623.22515-1-fu.wei@linaro.org>
References: <20161125084623.22515-1-fu.wei@linaro.org>
Message-ID: <20161125084623.22515-3-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patch add a new enum "arch_timer_spi_nr" and use it in the driver.
Just for code's readability, no functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 include/clocksource/arm_arch_timer.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 21068be..63bb532 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -960,9 +960,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	}
 
 	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, 1);
+		irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_VIRT_SPI);
 	else
-		irq = irq_of_parse_and_map(best_frame, 0);
+		irq = irq_of_parse_and_map(best_frame, ARCH_TIMER_PHYS_SPI);
 
 	ret = -EINVAL;
 	if (!irq) {
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 557f869..d23c381 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -46,6 +46,12 @@ enum arch_timer_ppi_nr {
 	MAX_TIMER_PPI
 };
 
+enum arch_timer_spi_nr {
+	ARCH_TIMER_PHYS_SPI,
+	ARCH_TIMER_VIRT_SPI,
+	ARCH_TIMER_MAX_TIMER_SPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
-- 
2.9.3
