From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Apr 2018 19:06:57 +0100
Subject: [RFC PATCH 5/8] arm64/sve: Switch sve_pffr() argument from task
 to thread
In-Reply-To: <1524242802-21163-6-git-send-email-Dave.Martin@arm.com>
References: <1524242802-21163-1-git-send-email-Dave.Martin@arm.com>
 <1524242802-21163-6-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180425180657.uz7xnz36gjqikqep@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 05:46:39PM +0100, Dave P Martin wrote:
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

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
