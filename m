From: cov@codeaurora.org (Christopher Covington)
Date: Tue,  9 Apr 2013 08:33:34 -0400
Subject: [PATCH v2] arm64: Fix task tracing
In-Reply-To: <20130408153132.GQ17476@mudshark.cambridge.arm.com>
References: <20130408153132.GQ17476@mudshark.cambridge.arm.com>
Message-ID: <1365510814-21343-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For accurate accounting pass contextidr_thread_switch the prev
task pointer, since cpu_switch_to has at that point changed the
the stack pointer.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0337cdb..a49b25a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -315,7 +315,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	/* the actual thread switch */
 	last = cpu_switch_to(prev, next);
 
-	contextidr_thread_switch(next);
+	contextidr_thread_switch(prev);
 	return last;
 }
 
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by the Linux Foundation.
