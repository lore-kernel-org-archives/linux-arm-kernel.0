From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 09:44:20 +0100
Subject: [PATCH v6 09/15] arm64/sve: Switch sve_pffr() argument from task
 to thread
In-Reply-To: <1525797900-5548-10-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
 <1525797900-5548-10-git-send-email-Dave.Martin@arm.com>
Message-ID: <05e693a7-0eba-ab33-5b89-e1b7e4e0cb5e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/18 17:44, Dave Martin wrote:
> sve_pffr(), which is used to derive the base address used for
> low-level SVE save/restore routines, currently takes the relevant
> task_struct as an argument.
> 
> The only accessed fields are actually part of thread_struct, so
> this patch changes the argument type accordingly.  This is done in
> preparation for moving this function to a header, where we do not
> want to have to include <linux/sched.h> due to the consequent
> circular #include problems.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
