From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:15:18 +0000
Subject: [PATCH 2/2] ARM: perf: remove erroneous semicolon from event
 initialisation
In-Reply-To: <1361805318-8477-1-git-send-email-will.deacon@arm.com>
References: <1361805318-8477-1-git-send-email-will.deacon@arm.com>
Message-ID: <1361805318-8477-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Gang <gang.chen@asianux.com>

Commit 9dcbf466559f ("ARM: perf: simplify __hw_perf_event_init err
handling") tidied up the error handling code for perf event
initialisation on ARM, but a copy-and-paste error left a dangling
semicolon at the end of an if statement.

This patch removes the broken semicolon, restoring the old group
validation semantics.

Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Dirk Behme <dirk.behme@gmail.com>
Signed-off-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
1.8.0
