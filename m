From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 13 Apr 2012 16:38:59 -0600 (MDT)
Subject: [PATCH] ARM: OMAP: clock: cleanup CPUfreq leftovers, fix build
 errors
In-Reply-To: <1334350335-1250-1-git-send-email-khilman@ti.com>
References: <1334350335-1250-1-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1204131638320.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Apr 2012, Kevin Hilman wrote:

> Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
> longer need/use the clock framework code for filling up CPUfreq
> tables.  Remove it.
> 
> Removing this code also eliminates build errors when CPU_FREQ_TABLE
> support is not enabled.
> 
> Thanks to Russell King for pointing out the parts I missed under
> plat-omap in the original version and also pointing out the build
> errors when CPUFREQ_TABLE support was not enabled.
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony/Paul, can you queue this up ASAP for v3.4-rc?  This was a cleanup
> that was targetted to go in to v3.4, but missed the merge window.  The
> cleanup is still needed, but now it's also a fix since this dead code
> also causes build errors when CPU_FREQ_TABLE support is not enabled.
> 
> Also, if we don't merge this patch, we'll have to rework it because
> Russell has queued an alternate fix to this which changes some of this
> code that should be removed instead:
> http://marc.info/?l=linux-arm-kernel&m=133434335009356&w=2
> However, if we get this fix in soon, Russell is willing to drop his 
> version.   
> 
>  arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   80 --------------------------
>  arch/arm/mach-omap2/clock.c                  |    5 --
>  arch/arm/mach-omap2/clock.h                  |    8 ---
>  arch/arm/plat-omap/clock.c                   |   26 ---------
>  arch/arm/plat-omap/include/plat/clock.h      |   10 ----

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
