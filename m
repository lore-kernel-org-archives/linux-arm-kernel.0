From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 20:25:14 +0800
Subject: [PATCH 20/20] ARM64 / clocksource: Use clocksource_acpi_init()
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1389961514-13562-21-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clocksource_acpi_init() on ARM64 to initialise timers
in ACPI way when DT is not available.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/time.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 29c39d5..6e453ac 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -67,6 +67,12 @@ void __init time_init(void)
 
 	clocksource_of_init();
 
+	/*
+	 * Since ACPI or FDT will only one be available in the system,
+	 * we can use clocksource_acpi_init() here safely
+	 */
+	clocksource_acpi_init();
+
 	arch_timer_rate = arch_timer_get_rate();
 	if (!arch_timer_rate)
 		panic("Unable to initialise architected timer.\n");
-- 
1.7.9.5
