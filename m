From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Jun 2012 11:41:51 +0100
Subject: [PATCH] ARM: perf: return -EOPNOTSUPP if requested mode exclusion is
 unavailable
Message-ID: <1339756911-16687-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently return -EPERM if the user requests mode exclusion that is
not supported by the CPU. This looks pretty confusing from userspace
and is inconsistent with other architectures (ppc, x86).

This patch returns -EOPNOTSUPP instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 186c8cb..a02eada 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -503,7 +503,7 @@ __hw_perf_event_init(struct perf_event *event)
 	     event_requires_mode_exclusion(&event->attr)) {
 		pr_debug("ARM performance counters do not support "
 			 "mode exclusion\n");
-		return -EPERM;
+		return -EOPNOTSUPP;
 	}
 
 	/*
-- 
1.7.4.1
