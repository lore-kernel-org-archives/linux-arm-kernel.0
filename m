From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 12 Feb 2013 12:43:54 +0100
Subject: [PATCH 1/2 v2] drivers/db8500-cpufreq: delete dangling include
Message-ID: <1360669434-21752-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

There was a dangling #include <mach/id.h> in the cpufreq
file missing from commit
7a4f26097d389c16c9956bc03b81532698d97d64
"ARM: ux500: de-globalize <mach/id.h>"

Causing build regressions when building with cpufreq
support.

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- introduce db8500 in the subject.
---
 drivers/cpufreq/db8500-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
index 523c940..87130e2 100644
--- a/drivers/cpufreq/db8500-cpufreq.c
+++ b/drivers/cpufreq/db8500-cpufreq.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <mach/id.h>
 
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *armss_clk;
-- 
1.7.11.3
