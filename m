From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 13:22:09 +0900
Subject: [PATCH 10/10] ARM: shmobile: Use SMP on Koelsch
In-Reply-To: <20131001081326.4136.95868.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081326.4136.95868.sendpatchset@w520>
Message-ID: <20131003042208.GM7925@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:13:26PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Enable r8a7791 SMP support code on the Koelsch board.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/board-koelsch.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 0008/arch/arm/mach-shmobile/board-koelsch.c
> +++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-01 16:40:07.000000000 +0900
> @@ -39,6 +39,7 @@ static const char * const koelsch_boards
>  };
>  
>  DT_MACHINE_START(KOELSCH_DT, "koelsch")
> +	.smp		= smp_ops(r8a7791_smp_ops),
>  	.init_early	= r8a7791_init_early,
>  	.init_machine	= koelsch_add_standard_devices,
>  	.init_time	= rcar_gen2_timer_init,

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.

The boards3 branch includes boards code previously queued up for v3.13
and a merge with soc changes previously queued up for v3.13. The reason
for the merge is to provide various build and run-time dependencies
including the r8a7791 SoC code which this patch uses.
