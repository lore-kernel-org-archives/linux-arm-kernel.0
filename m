From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Jun 2015 17:17:28 +0100
Subject: [PATCHv2 1/7] arm: perf: factor arm_pmu core out to drivers
In-Reply-To: <1434041060-16378-2-git-send-email-mark.rutland@arm.com>
References: <1434041060-16378-1-git-send-email-mark.rutland@arm.com>
 <1434041060-16378-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20150616161728.GI30522@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Jun 11, 2015 at 05:44:14PM +0100, Mark Rutland wrote:
> To enable sharing of the arm_pmu code with arm64, this patch factors it
> out to drivers/perf/. A new drivers/perf directory is added for
> performance monitor drivers to live under.
> 
> MAINTAINERS is updated accordingly, with myself added as a reviewer as
> suggested by Will Deacon. The wildcard for arch/arm is updated to cover
> perf_regs.c and perf_callchain.c, which were added previously without a
> corresponding MAINTAINERS update.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  MAINTAINERS                                                |  6 ++++--

Can you put the MAINTAINERS changes in a separate patch, please?

>  arch/arm/Kconfig                                           |  8 ++------
>  arch/arm/kernel/Makefile                                   |  3 +--
>  arch/arm/kernel/perf_event_v6.c                            |  2 +-
>  arch/arm/kernel/perf_event_v7.c                            |  2 +-
>  arch/arm/kernel/perf_event_xscale.c                        |  2 +-
>  arch/arm/mach-ux500/cpu-db8500.c                           |  2 +-
>  drivers/Kconfig                                            |  2 ++
>  drivers/Makefile                                           |  1 +
>  drivers/perf/Kconfig                                       | 14 ++++++++++++++
>  drivers/perf/Makefile                                      |  1 +
>  arch/arm/kernel/perf_event.c => drivers/perf/arm_pmu.c     |  2 +-
>  arch/arm/include/asm/pmu.h => include/linux/perf/arm_pmu.h |  4 ++--

I wonder whether that's such a good name for the subsystem. We already
have a bunch of perf_* headers directly under include/linux/ for the perf
core interfaces, so maybe drivers/pmu/ would be better?

Will
