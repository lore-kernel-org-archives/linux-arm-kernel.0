From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 14 Jun 2017 14:39:35 +0200
Subject: [PATCH 14/23] clocksource/drivers: Rename CLOCKSOURCE_ACPI_DECLARE to
 TIMER_ACPI_DECLARE
In-Reply-To: <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170614123800.GH2261@mai>
 <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1497443984-12371-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macro name is now renamed to 'TIMER_ACPI_DECLARE' for consistency
with the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 include/linux/clocksource.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index bc60cd7..a89d41c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1516,5 +1516,5 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	return arch_timer_common_init();
 }
-CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
+TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 010bb9f..e43f37f 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -258,7 +258,7 @@ extern void timer_probe(void);
 static inline void timer_probe(void) {}
 #endif
 
-#define CLOCKSOURCE_ACPI_DECLARE(name, table_id, fn)		\
+#define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(clksrc, name, table_id, 0, NULL, 0, fn)
 
 #endif /* _LINUX_CLOCKSOURCE_H */
-- 
2.7.4
