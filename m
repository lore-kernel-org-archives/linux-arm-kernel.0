From: santosh.shilimkar@ti.com (Santosh)
Date: Sat, 03 Sep 2011 22:06:38 +0530
Subject: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Message-ID: <4E625796.1020109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 September 2011 06:17 PM, Russell King - ARM Linux wrote:
> Some systems (such as OMAP) preserve the L2 cache across a suspend/
> resume cycle.  This means they do not perform L2 cache maintanence
> in their suspend finisher function.
>
> However, the side effect is that the saved CPU state is not readable
> by the resume code because it is sitting in the L2 cache.
>
> This patch series adds L2 cache cleaning to the generic CPU suspend/
> resume support code, making it possible to use this on systems with
> L2 cache enabled without having to clean/invalidate the entire L2
> cache.
>
> We also add a separate page table, allocated at boot time, for the
> resume process to use so we don't have to fiddle about with tweaking
> entries in the current processes page table.  Moreover, the current
> processes page table may be in use by another CPU in the system if
> these paths are used from cpuidle or hotplug, so changing the page
> table is technically unsound.
>
> Overall, this makes it possible for OMAP4 systems to use this code.
>
> The first four patches in this set are already merged into Linus' tree
> as bug fixes, and are included here for completeness given that the
> kernel.org infrastructure is currently offline.
>
> This has (so far) only been tested on OMAP4.  Further testing on OMAP3
> and Assabet will follow.

Thanks a lot Russell for this series. I have tested the entire series
with OMAP4 S2R and CPUIDLE and it works great.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
