From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Jul 2014 22:07:09 +0800
Subject: [PATCH] ARM: add revision info for PL310 errata 588369 and 727915
In-Reply-To: <1404285816-3763-1-git-send-email-shawn.guo@freescale.com>
References: <1404285816-3763-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140707140708.GU30239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 03:23:36PM +0800, Shawn Guo wrote:
> Add revision info for PL310_ERRATA_588369 and PL310_ERRATA_727915 to
> help people understand if they need to enable the errata for their
> hardware.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Any comments on this patch?  Otherwise, I'm going to throw it into
the patch system.

Shawn

> ---
>  arch/arm/mm/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index eda0dd0ab97b..9fb8a02b7e35 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -907,8 +907,8 @@ config PL310_ERRATA_588369
>  	   They are architecturally defined to behave as the execution of a
>  	   clean operation followed immediately by an invalidate operation,
>  	   both performing to the same memory location. This functionality
> -	   is not correctly implemented in PL310 as clean lines are not
> -	   invalidated as a result of these operations.
> +	   is not correctly implemented in PL310 prior to r2p0 (fixed in r2p0)
> +	   as clean lines are not invalidated as a result of these operations.
>  
>  config PL310_ERRATA_727915
>  	bool "PL310 errata: Background Clean & Invalidate by Way operation can cause data corruption"
> @@ -919,7 +919,8 @@ config PL310_ERRATA_727915
>  	  PL310 can handle normal accesses while it is in progress. Under very
>  	  rare circumstances, due to this erratum, write data can be lost when
>  	  PL310 treats a cacheable write transaction during a Clean &
> -	  Invalidate by Way operation.
> +	  Invalidate by Way operation.  Revisions prior to r3p1 are affected by
> +	  this errata (fixed in r3p1).
>  
>  config PL310_ERRATA_753970
>  	bool "PL310 errata: cache sync operation may be faulty"
> -- 
> 1.8.3.2
> 
