From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Feb 2016 11:40:03 +0000
Subject: [PATCH 00/13] arm-cci: PMU driver updates for 4.6
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160223114003.GF3966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 10:49:42AM +0000, Suzuki K Poulose wrote:
> Here are some fixes and updates for arm-cci pmu driver targeting v4.6,
> applies on top of v4.5-rc5.
> 
> Highlights include :
>  - Support for CoreLink CCI-550 PMU
>  - Reliable writes to PMU Counter registers for CCI-500/550.
> 
> All the patches have been Acked. Please let me know how this
> can be merged.
> 
> Andrzej Hajda (1):
>   arm-cci: fix handling cpumask_any_but return value
> 
> Mark Rutland (1):
>   arm-cci: simplify sysfs attr handling
> 
> Suzuki K Poulose (11):
>   arm-cci: Group writes to counter
>   arm-cci: Refactor CCI PMU enable/disable methods
>   arm-cci: Delay PMU counter writes to pmu::pmu_enable
>   arm-cci: write_counter: Remove redundant check
>   arm-cci: Get the status of a counter
>   arm-cci: Add routines to save/restore all counters
>   arm-cci: Add helper to enable PMU without synchornising counters
>   arm-cci: Provide hook for writing to PMU counters
>   arm-cci: CCI-500: Work around PMU counter writes
>   arm-cci500: Rearrange PMU driver for code sharing with CCI-550 PMU
>   arm-cci: CoreLink CCI-550 PMU driver
> 
>  Documentation/devicetree/bindings/arm/cci.txt |    2 +
>  drivers/bus/Kconfig                           |   10 +-
>  drivers/bus/arm-cci.c                         |  612 +++++++++++++++++--------
>  3 files changed, 427 insertions(+), 197 deletions(-)

How do you plan to merge this? I can take it all onto a branch for
arm-soc, or I can include it on my perf/updates branch, or ...?

Will
