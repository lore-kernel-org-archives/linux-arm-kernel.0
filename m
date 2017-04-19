From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Apr 2017 17:44:22 +0100
Subject: [PATCH 05/16] clocksource: arm_arch_timer: add a new enum for spi type
In-Reply-To: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
References: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1492620273-30037-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patch add a new enum "arch_timer_spi_nr" and use it in the driver.
Just for code's readability, no functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 include/clocksource/arm_arch_timer.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 04218c1..15059c9 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1258,9 +1258,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
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
index b898637..4a98c06 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -46,6 +46,12 @@ enum arch_timer_ppi_nr {
 	ARCH_TIMER_MAX_TIMER_PPI
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
1.9.1
