From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Jul 2015 17:13:19 +0100
Subject: [PATCHv3 1/9] arm: perf: factor arm_pmu core out to drivers
In-Reply-To: <1436181842-19402-2-git-send-email-mark.rutland@arm.com>
References: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
 <1436181842-19402-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20150720161318.GK9908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Jul 06, 2015 at 12:23:53PM +0100, Mark Rutland wrote:
> To enable sharing of the arm_pmu code with arm64, this patch factors it
> out to drivers/perf/. A new drivers/perf directory is added for
> performance monitor drivers to live under.
> 
> MAINTAINERS is updated accordingly. Files added previously without a
> corresponsing MAINTAINERS update (perf_regs.c, perf_callchain.c, and
> perf_event.h) are also added.
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
>  13 files changed, 32 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/perf/Kconfig
>  create mode 100644 drivers/perf/Makefile
>  rename arch/arm/kernel/perf_event.c => drivers/perf/arm_pmu.c (99%)
>  rename arch/arm/include/asm/pmu.h => include/linux/perf/arm_pmu.h (98%)

I'd like to take this for 4.3 on top of my current queue of ARM perf
updates. I've put together a branch, but it's not clear which tree this
should go through.

Russell: would you be ok taking this via the ARM tree, or would you
prefer it if I sent this via arm-soc? Personally, I think it makes sense
to send it to you along with the usual updates, but I appreciate you
don't normally touch drivers/ directly like this.

Will
