From: alex.bluesman.smirnov@gmail.com (Alexander Smirnov)
Date: Fri,  5 Aug 2011 12:31:51 +0400
Subject: [PATCH] fix cpuidle_xxx functions name mismatch
Message-ID: <1312533111-22231-1-git-send-email-alex.bluesman.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In header there is defined 'cpuidle_idle_call' function,
in arm/kernel/process.c file it's used 'cpuidle_call_idle'

Signed-off-by: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
---
 arch/arm/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d7ee0d4..1a347f4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -197,7 +197,7 @@ void cpu_idle(void)
 				cpu_relax();
 			} else {
 				stop_critical_timings();
-				if (cpuidle_call_idle())
+				if (cpuidle_idle_call())
 					pm_idle();
 				start_critical_timings();
 				/*
-- 
1.7.2.3
