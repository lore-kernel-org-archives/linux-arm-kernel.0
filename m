From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 17 Feb 2013 12:27:45 +0800
Subject: [PATCH v2] ARM:kernel: a bug for perf by a redundancy character ';'
Message-ID: <51205C41.80609@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  delete the redundancy character ';', which will cause issue.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
Acked-by: Dirk Behme <dirk.behme@gmail.com>
---
 arch/arm/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 31e0eb3..a892067 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -400,7 +400,7 @@ __hw_perf_event_init(struct perf_event *event)
 	}
 
 	if (event->group_leader != event) {
-		if (validate_group(event) != 0);
+		if (validate_group(event) != 0)
 			return -EINVAL;
 	}
 
-- 
1.7.7.6
