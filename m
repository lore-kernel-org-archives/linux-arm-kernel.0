From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 13 Mar 2014 19:13:45 +0900
Subject: [PATCH v6 2/7] arm64: Add 'notrace' attribute to unwind_frame() for
 ftrace
In-Reply-To: <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
References: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1394705630-12384-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

walk_stackframe() calls unwind_frame(), and if walk_stackframe() is
"notrace", unwind_frame() should be also "notrace".

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/stacktrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index c3b6c63..54122c4 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -35,7 +35,7 @@
  *	ldp	x29, x30, [sp]
  *	add	sp, sp, #0x10
  */
-int unwind_frame(struct stackframe *frame)
+int notrace unwind_frame(struct stackframe *frame)
 {
 	unsigned long high, low;
 	unsigned long fp = frame->fp;
-- 
1.7.9.5
