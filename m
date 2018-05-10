From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 May 2018 17:15:26 +0100
Subject: [PATCH v7 01/16] thread_info: Add update_thread_flag() helpers
In-Reply-To: <1525882385-29181-2-git-send-email-Dave.Martin@arm.com>
References: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
 <1525882385-29181-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180510161525.l3hmxmtssk2s5xov@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:12:50PM +0100, Dave P Martin wrote:
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
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Oleg Nesterov <oleg@redhat.com>

FWIW,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
