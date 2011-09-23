From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 24 Sep 2011 01:22:25 +0800
Subject: [PATCH] ARM: localtimer: add header linux/errno.h explicitly
Message-ID: <1316798545-21128-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per the text in  Documentation/SubmitChecklist as below, we should
explicitly have header linux/errno.h in localtimer.h for ENXIO
reference.

1: If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.

Otherwise, we may run into some compiling error like the following one,
if any file includes localtimer.h without CONFIG_LOCAL_TIMERS defined.

  arch/arm/include/asm/localtimer.h: In function ?local_timer_setup?:
  arch/arm/include/asm/localtimer.h:53:10: error: ?ENXIO? undeclared (first use in this function)

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/include/asm/localtimer.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 080d74f..698ff73 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -48,6 +48,8 @@ int local_timer_setup(struct clock_event_device *);
 
 #else
 
+#include <linux/errno.h>
+
 static inline int local_timer_setup(struct clock_event_device *evt)
 {
 	return -ENXIO;
-- 
1.7.4.1
