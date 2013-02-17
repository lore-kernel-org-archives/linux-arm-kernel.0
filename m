From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 17 Feb 2013 10:09:13 +0800
Subject: [PATCH] ARM:kernel: a bug for perf by a redundancy character ';'
In-Reply-To: <20130216122646.GA14174@mudshark.cambridge.arm.com>
References: <511F2C0D.4030206@asianux.com> <511F3D8C.6090603@gmail.com>
 <511F4574.7000707@asianux.com>
 <20130216122646.GA14174@mudshark.cambridge.arm.com>
Message-ID: <51203BC9.60600@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  delete the redundancy charactor ';', which will cause issue.

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
