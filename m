From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Apr 2017 18:02:03 +0100
Subject: [PATCH v1] arm64: Add support for on-demand backtrace of other
 CPUs
In-Reply-To: <1489735663-2091-2-git-send-email-andr2000@gmail.com>
References: <1489735663-2091-1-git-send-email-andr2000@gmail.com>
 <1489735663-2091-2-git-send-email-andr2000@gmail.com>
Message-ID: <20170407170203.GC20645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 09:27:43AM +0200, Oleksandr Andrushchenko wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently arm64 has no implementation of arch_trigger_cpumask_backtrace.
> The patch provides one using library code recently added by Russell King
> for for the majority of the implementation. Currently this is realized
> using regular irqs but could, in the future, be implemented using
> NMI-like mechanisms.
> 
> Note: There is a small (and nasty) change to the generic code to ensure
>       good stack traces. The generic code currently assumes that
>       show_regs() will include a stack trace but arch/arm64 does not do
>       this so we must add extra code here. Ideas on a better approach
>       here would be very welcome (is there any appetite to change arm64
>       show_regs() or should we just tease out the dump code into a
>       callback?).

Please see this discussion here:

http://lkml.kernel.org/r/20170323150357.GH9287 at leverpostej

I'm not a ware of a follow up but if we change the arm64 show_regs() to
dump the stack, we no longer need the generic code hunk in your patch.

-- 
Catalin
