From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 May 2015 16:47:10 +0100
Subject: [PATCH 7/7] arm: perf: factor arm_pmu core out to drivers
In-Reply-To: <1432657420-887-8-git-send-email-mark.rutland@arm.com>
References: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
 <1432657420-887-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20150528154709.GL31001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 05:23:40PM +0100, Mark Rutland wrote:
> To enable sharing of the arm_pmu code with arm64, this patch factors it
> out to drivers/perf/. A new drivers/perf directory is added for
> performance monitor drivers to live under.
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

Can you also update MAINTAINERS ("ARM PMU PROFILING AND DEBUGGING") to
reflect the effective file moves, please? I'm also more than happy for
you to add yourself as a reviewer ("R:") entry, if you feel that way
inclined.

Will
