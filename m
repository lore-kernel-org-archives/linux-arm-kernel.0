From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 27 Aug 2014 13:25:43 -0700
Subject: [PATCH V2 4/7] ARM: OMAP2+: powerdomain: introduce logic for
 finding valid power domain
In-Reply-To: <1409165694-26568-1-git-send-email-nm@ti.com> (Nishanth Menon's
 message of "Wed, 27 Aug 2014 13:54:54 -0500")
References: <1408715373-25791-1-git-send-email-nm@ti.com>
 <1409165694-26568-1-git-send-email-nm@ti.com>
Message-ID: <7h1ts1bry0.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> powerdomain configuration in OMAP is done using PWRSTCTRL register for
> each power domain. However, PRCM lets us write any value we'd like to
> the logic and power domain target states, however the SoC integration
> tends to actually function only at a few discrete states. These valid
> states are already in our powerdomains_xxx_data.c file.
>
> So, provide a function to easily query valid low power state that the
> power domain is allowed to go to.
>
> Based on work originally done by Jean Pihet <j-pihet@ti.com>
> https://patchwork.kernel.org/patch/1325091/ . There is no attempt to
> create a new powerdomain solution here, except fixing issues seen
> attempting invalid programming attempts. Future consolidation to the
> generic powerdomain framework should consider this requirement as
> well.
>
> Similar solutions have been done in product kernels in the past such
> as:
> https://android.googlesource.com/kernel/omap.git/+blame/android-omap-panda-3.0/arch/arm/mach-omap2/pm44xx.c
>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>
> Not posting the entire series again and updating just this patch..
>
> V2: drop BUG in favor of WARN, picked up Santosh and Kevin's acks.

Looks good, thanks,

Kevin
