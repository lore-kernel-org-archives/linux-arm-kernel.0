From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 11 Feb 2016 14:28:34 +0100
Subject: [PATCH v3 0/5] Cavium ThunderX PMU support
In-Reply-To: <cover.1454516082.git.jglauber@cavium.com>
References: <cover.1454516082.git.jglauber@cavium.com>
Message-ID: <20160211132833.GA16164@wintermute>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:11:55PM +0100, Jan Glauber wrote:
> Hi,
> 
> I'm reposting the whole series just in case my previous attempt to
> repost only the broken patch was confusing. Patches are based on
> 4.5-rc2.

Can I get a review for these patches?

thanks,
Jan

> Patches 1-3 add support for ThunderX specific PMU events.
> 
> Patch 4 changes the cycle counter to overflow on 64 bit but tries to minimize
> code changes. Without this change perf does not work at all on ThunderX.
> 
> Patch 5 extends the event mask according to ARMv8.1 and also affects arm32.
> 
> Changes to v2:
> - fixed arm compile errors
> 
> Changes to v1:
> - renamed thunderx dt pmu binding to thunder
> 
> --Jan
> 
> Jan Glauber (5):
>   arm64/perf: Rename Cortex A57 events
>   arm64/perf: Add Cavium ThunderX PMU support
>   arm64: dts: Add Cavium ThunderX specific PMU
>   arm64/perf: Enable PMCR long cycle counter bit
>   arm64/perf: Extend event mask for ARMv8.1
> 
>  Documentation/devicetree/bindings/arm/pmu.txt |   1 +
>  arch/arm/kernel/perf_event_v6.c               |   6 +-
>  arch/arm/kernel/perf_event_v7.c               |  29 ++++--
>  arch/arm/kernel/perf_event_xscale.c           |   4 +-
>  arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  |   5 +
>  arch/arm64/kernel/perf_event.c                | 145 ++++++++++++++++++++------
>  drivers/perf/arm_pmu.c                        |   5 +-
>  include/linux/perf/arm_pmu.h                  |   4 +-
>  8 files changed, 151 insertions(+), 48 deletions(-)
> 
> -- 
> 1.9.1
