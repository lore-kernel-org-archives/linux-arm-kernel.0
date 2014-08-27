From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 27 Aug 2014 11:30:55 -0700
Subject: [PATCH 0/7] ARM: OMAP4+: powerdomain fixes
In-Reply-To: <1408715373-25791-1-git-send-email-nm@ti.com> (Nishanth Menon's
 message of "Fri, 22 Aug 2014 08:49:26 -0500")
References: <1408715373-25791-1-git-send-email-nm@ti.com>
Message-ID: <7hwq9tdbts.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> The following series are various fixes and improvements for
> powerdomain support in OMAP4+.

Ah, here I see "fixes and improvements" since I was about to nipick that
the series contains more than just fixes.

Anyways, the series looks good to me.  After fixing up the BUG_ON issue,
feel free to add

Reviewed-by: Kevin Hilman <khilman@linaro.org>

> This is part 1/6 series which eventually enables framework for
> suspend-to-ram and cpuidle for OMAP5 and DRA7
>
> Each of series is based on v3.17-rc1 and this specific series is available:
> weblink: https://github.com/nmenon/linux-2.6-playground/commits/push/v3.17/powerdomain-fixes
>
> git repo: https://github.com/nmenon/linux-2.6-playground.git push/v3.17/powerdomain-fixes
>
> An complete integrated branch is available here: https://github.com/nmenon/linux-2.6-playground/commits/testing/v3.17/cpu-idle-suspend-dra7-omap5-framework
>
> Nishanth Menon (7):
>   ARM: OMAP: DRA7: powerdomain data: fix powerdomain powerstate
>   ARM: OMAP5: powerdomain data: fix powerdomain powerstate
>   ARM: OMAP2+: powerdomain: pwrdm_for_each_clkdm iterate only valid
>     clkdms
>   ARM: OMAP2+: powerdomain: introduce logic for finding valid power
>     domain
>   ARM: OMAP4+: PM: Make logic state programmable
>   ARM: OMAP4+: PM: use only valid low power state for suspend
>   ARM: OMAP4+: PM: Use only valid low power state for CPU hotplug
>
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c   |    4 ++
>  arch/arm/mach-omap2/pm44xx.c                |    9 +++-
>  arch/arm/mach-omap2/powerdomain.c           |   76 ++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/powerdomain.h           |    4 ++
>  arch/arm/mach-omap2/powerdomains54xx_data.c |   12 ++---
>  arch/arm/mach-omap2/powerdomains7xx_data.c  |   14 ++---
>  6 files changed, 103 insertions(+), 16 deletions(-)
