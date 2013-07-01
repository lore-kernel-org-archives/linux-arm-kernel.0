From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Jul 2013 11:02:06 +0900
Subject: [PATCH 00/04] ARM: shmobile: r8a73a4/r8a7790 CMT and Arch timer
 update
In-Reply-To: <20130628112655.23809.39115.sendpatchset@w520>
References: <20130628112655.23809.39115.sendpatchset@w520>
Message-ID: <20130701020206.GE14567@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 08:26:55PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a73a4/r8a7790 CMT and Arch timer update
> 
> [PATCH 01/04] ARM: shmobile: Add r8a7790 CMT00 clock event
> [PATCH 02/04] ARM: shmobile: Make r8a7790 Arch timer optional
> [PATCH 03/04] ARM: shmobile: Add r8a73a4 CMT10 clock event
> [PATCH 04/04] ARM: shmobile: Make r8a73a4 Arch timer optional
> 
> Add clock event support through a CMT timer channel for the
> SoCs r8a7790 and r8a73a4 as well as APE6EVM and Lager boards.
> 
> Also, to be able to test the CMT timers, make it possible to
> deselect Arch timer and instead rely on predefined values for
> udelay() and instead of local timer for SMP use broadcast.
> 
> A nice side effect of this is that high resolution timers
> now become available. The reason for the is that the Arch
> timer sets the C3STOP flag which in turn will tell the
> time keeping code to not allow high resolution timer without
> an additional clock event. So here they are.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git renesas-next-20130628 plus
>  [PATCH] ARM: shmobile: Sort r8a7790 MSTP entries
>  [PATCH 00/06] ARM: shmobile: Remove unused auxdata tables
> 
>  For proper run time operation the following patch
>  included in renesas-next-20130628 must be included
>  in the CMT driver:

Thanks, Magnus.

I have queued these up in the soc branch.

I applied the first patch of the series manually as there was
some conflicts for one reason or another. Please check that I applied
it correctly.
