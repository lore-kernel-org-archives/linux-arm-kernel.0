From: robherring2@gmail.com (Rob Herring)
Date: Mon, 11 Mar 2013 08:45:51 -0500
Subject: [PATCH] clocksource: add empty version of clocksource_of_init
Message-ID: <1363009551-8978-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add an empty clocksource_of_init when !CLKSRC_OF. This is needed for builds
where no timer has selected CLKSRC_OF.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
This is part of my CLKSRC_OF init rework. It is also needed for
Arnd's default machine patch. I plan to send a pull request to arm-soc
for all this shortly.

Rob

 include/linux/clocksource.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 27cfda4..08ed5e1 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -340,6 +340,7 @@ extern void clocksource_of_init(void);
 		__used __section(__clksrc_of_table)			\
 		 = { .compatible = compat, .data = fn };
 #else
+static inline void clocksource_of_init(void) {}
 #define CLOCKSOURCE_OF_DECLARE(name, compat, fn)
 #endif
 
-- 
1.7.10.4
