From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 10:07:51 +0100
Subject: [PATCH v6 01/15] thread_info: Add update_thread_flag() helpers
In-Reply-To: <1525797900-5548-2-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
 <1525797900-5548-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <86456061-b9cc-2941-23de-e41f05b05580@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/18 17:44, Dave Martin wrote:
> There are a number of bits of code sprinkled around the kernel to
> set a thread flag if a certain condition is true, and clear it
> otherwise.
> 
> To help make those call sites terser and less cumbersome, this
> patch adds a new family of thread flag manipulators
> 
> 	update*_thread_flag([...,] flag, cond)
> 
> which do the equivalent of:
> 
> 	if (cond)
> 		set*_thread_flag([...,] flag);
> 	else
> 		clear*_thread_flag([...,] flag);
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
