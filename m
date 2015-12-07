From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Dec 2015 22:48:07 +0000
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <1449226948-14251-4-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
Message-ID: <20151207224805.GA20777@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 11:02:27AM +0000, James Morse wrote:
> entry.S is modified to switch to the per_cpu irq_stack during el{0,1}_irq.
> irq_count is used to detect recursive interrupts on the irq_stack, it is
> updated late by do_softirq_own_stack(), when called on the irq_stack, before
> __do_softirq() re-enables interrupts to process softirqs.
> 
> do_softirq_own_stack() is added by this patch, but does not yet switch
> stack.
> 
> This patch adds the dummy stack frame and data needed by the previous
> stack tracing patches.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

In the interest of getting things moving on this series:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I propose that we skip patch 4 for now and, as James suggested, keep the
THREAD_SIZE to 16KB for one more release cycle. It would be good to get
some statistics on stack usage.

Patches 1-3 look fine to me on their own.

-- 
Catalin
