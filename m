From: broonie@kernel.org (Mark Brown)
Date: Fri,  9 May 2014 12:57:45 +0100
Subject: [PATCH] arm64: Define _TIF_POLLING_NRFLAG
Message-ID: <1399636665-4127-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

arm64 defines TIF_POLLING_NRFLAG but not the corresponding shifted version,
breaking the build with next-20140509 due to fd99f91aa007b (sched/idle:
Avoid spurious wakeup IPIs) which added a reference to the shifted version
which is present on most arches.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/include/asm/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 720e70b66ffd..40ff87437734 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -113,6 +113,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_32BIT		(1 << TIF_32BIT)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME)
-- 
2.0.0.rc2
