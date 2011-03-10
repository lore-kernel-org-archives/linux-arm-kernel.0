From: khilman@ti.com (Kevin Hilman)
Date: Thu, 10 Mar 2011 12:24:39 -0800
Subject: [PATCH v2 0/5] OMAP3: PM: Fixes for low power code
In-Reply-To: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Thu, 10 Mar 2011 12:37:12 +0530")
References: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87ei6eiv08.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The series does below fixes to the omap3 low power code.
> 	1. Use supported ARMv7 instructions instead of the legacy ones
> 	2. Fix the MMU on sequence
> 	3. Fix the cache flush scenario when only L1 lost.
> 	4. Remove all un-necessary context save registers
> 	5. Disable C-bit before cache clean
>
> V2:
> - Rebased series on top of pm-core branch where the Dave Martin's
>   Thumb2 patches are merged.
> - Dropped set_cr() patch since it's already merged in pm-core branch
> - Fixed the hang issue reported by Kevin Hilman with OMAP3630

Thanks for the updates.

I've been testing the previous series along with Paul's integration
branch and things look good.

Will re-test with this updated version and queue for 2.6.39 (branch:
for_2.6.39/pm-misc)

Thanks,

Kevin

> It's generated against latest pm-core branch and tested suspend
> and cpuilde on OMAP3630 ZOOM.
>
> The following changes since commit 7d6d079fbd46aee85e9b5de1d67de15b85e50b04:
>   Kevin Hilman (1):
>         Merge branch 'for_2.6.39/pm-voltage' into pm-reset
>
> are available in the git repository at:
>
>   git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
> pm-core-omap3-asm_v2
>
> Santosh Shilimkar (5):
>   OMAP3: PM: Use ARMv7 supported instructions instead of legacy CP15
>     ones
>   OMAP3: PM: Fix the MMU on sequence in the asm code
>   OMAP3: PM: Allow the cache clean when L1 is lost.
>   OMAP3: PM: Remove un-necessary cp15 registers form low power cpu
>     context
>   OMAP3: PM: Clear the SCTLR C bit in asm code to prevent data cache
>     allocation
>
>  arch/arm/mach-omap2/sleep34xx.S |  224 +++++++++++++++------------------------
>  1 files changed, 85 insertions(+), 139 deletions(-)
