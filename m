From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 9 May 2014 19:06:49 +0200
Subject: [RFC][PATCH 6/8] sched,idle: Avoid spurious wakeup IPIs
In-Reply-To: <20140509170234.GZ30445@twins.programming.kicks-ass.net>
References: <20140411134243.160989490@infradead.org>
 <20140411135218.478299389@infradead.org>
 <CAAG0J9_q1KsUx10-XAb7AJnxv2ehctg6q1KME7ahsk1OZV8vZQ@mail.gmail.com>
 <20140509141520.GV2844@laptop.programming.kicks-ass.net>
 <20140509144034.GF7950@arm.com>
 <20140509145002.GW2844@laptop.programming.kicks-ass.net>
 <20140509145745.GI7950@arm.com>
 <20140509170234.GZ30445@twins.programming.kicks-ass.net>
Message-ID: <20140509170649.GG13658@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 07:02:34PM +0200, Peter Zijlstra wrote:
> OK, so I'll queue a patch removing TIF_POLLING_NRFLAG for arm64.


---
Subject: arm64: Remove TIF_POLLING_NRFLAG
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri May  9 19:04:00 CEST 2014

The only idle method for arm64 is WFI and it therefore
unconditionally requires the reschedule interrupt when idle.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/arm64/include/asm/thread_info.h |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -95,13 +95,11 @@ static inline struct thread_info *curren
  *  TIF_NEED_RESCHED	- rescheduling necessary
  *  TIF_NOTIFY_RESUME	- callback before returning to user
  *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
- *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
  */
 #define TIF_SIGPENDING		0
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
-#define TIF_POLLING_NRFLAG	16
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/63698086/attachment.sig>
