From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 May 2014 13:30:20 +0100
Subject: [PATCH] arm64: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <1399322907-21280-1-git-send-email-larry.bassel@linaro.org>
References: <1399322907-21280-1-git-send-email-larry.bassel@linaro.org>
Message-ID: <20140506123020.GC30234@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 09:48:27PM +0100, Larry Bassel wrote:
> Support for arch_irq_work_raise() was missing from
> arm64 (a prerequisite for FULL_NOHZ).
> 
> This patch is based on the arm32 patch ARM 7872/1
> which ports cleanly.
> 
> commit bf18525fd793101df42a1344ecc48b49b62e48c9
> Author: Stephen Boyd <sboyd@codeaurora.org>
> Date:   Tue Oct 29 20:32:56 2013 +0100
> 
>     ARM: 7872/1: Support arch_irq_work_raise() via self IPIs
> 
>     By default, IRQ work is run from the tick interrupt (see
>     irq_work_run() in update_process_times()). When we're in full
>     NOHZ mode, restarting the tick requires the use of IRQ work and
>     if the only place we run IRQ work is in the tick interrupt we
>     have an unbreakable cycle. Implement arch_irq_work_raise() via
>     self IPIs to break this cycle and get the tick started again.
>     Note that we implement this via IPIs which are only available on
>     SMP builds. This shouldn't be a problem because full NOHZ is only
>     supported on SMP builds anyway.
> 
>     Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>     Reviewed-by: Kevin Hilman <khilman@linaro.org>
>     Cc: Frederic Weisbecker <fweisbec@gmail.com>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Signed-off-by: Larry Bassel <larry.bassel@linaro.org>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

Looks fine to me, thanks.

Will
