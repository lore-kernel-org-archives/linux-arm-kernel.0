From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 13:21:34 +0900
Subject: [PATCH 07/10] ARM: shmobile: Use arch timer on Koelsch
In-Reply-To: <20131001081257.4136.80053.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081257.4136.80053.sendpatchset@w520>
Message-ID: <20131003042133.GL7925@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:12:57PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Make use of the R-Car Gen2 arch timer workaround on Koelsch.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/board-koelsch.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- 0003/arch/arm/mach-shmobile/board-koelsch.c
> +++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-01 16:35:52.000000000 +0900
> @@ -23,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <mach/common.h>
>  #include <mach/r8a7791.h>
> +#include <mach/rcar-gen2.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  
> @@ -40,5 +41,6 @@ static const char * const koelsch_boards
>  DT_MACHINE_START(KOELSCH_DT, "koelsch")
>  	.init_early	= r8a7791_init_early,
>  	.init_machine	= koelsch_add_standard_devices,
> +	.init_time	= rcar_gen2_timer_init,
>  	.dt_compat	= koelsch_boards_compat_dt,
>  MACHINE_END

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.

The boards3 branch includes boards code previously queued up for v3.13
and a merge with soc changes previously queued up for v3.13. The reason
for the merge is to provide various build and run-time dependencies
including the rcar_gen2_timer_init code which this patch uses.
