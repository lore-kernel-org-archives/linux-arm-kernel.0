From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 29 Nov 2015 01:32:36 +0900
Subject: [PATCH v7 1/3] arm64: Add irq_stack boiler plate,
 store struct task_info in sp_el0
In-Reply-To: <1447698128-8490-2-git-send-email-james.morse@arm.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
 <1447698128-8490-2-git-send-email-james.morse@arm.com>
Message-ID: <C4231496-71BE-4D48-9575-D375D141136D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 17, 2015, at 3:22 AM, James Morse wrote:

Hi James,

> From: Jungseok Lee <jungseoklee85@gmail.com>
> 
> There is need for figuring out how to manage struct thread_info data when
> IRQ stack is introduced. struct thread_info information should be copied
> to IRQ stack under the current thread_info calculation logic whenever
> context switching is invoked. This is too expensive to keep supporting
> the approach.
> 
> Instead, this patch pays attention to sp_el0 which is an unused scratch
> register in EL1 context. sp_el0 utilization not only simplifies the
> management, but also prevents text section size from being increased
> largely due to static allocated IRQ stack as removing masking operation
> using THREAD_SIZE in many places.
> 
> This patch adds per_cpu definitions and initialisation for the irq_stack,
> that will be used by a later patch.
> 
> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> [Added per_cpu definitions and initialisation for irq_stack]

How about moving all irq_stack items to [PATCH 2/3] or [PATCH 3/3]?

First of all, I'd like to focus on only thread_info management, which has
no objection yet, via this patch. Secondly, this hunk is now considered
a common part for IRQ stack written by both of us. If a process stack is
allowed in softirq context, I will wait for your next version. If "always
switch" method is picked up, I'd like to write down the feature based on
this patch.

Best Regards
Jungseok Lee
