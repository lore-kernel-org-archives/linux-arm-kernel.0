From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Jan 2014 17:20:03 +0900
Subject: [PATCH] ARM: shmobile: emev2: Use __initconst for const init
 definition
In-Reply-To: <1388114048-3630-1-git-send-email-horms+renesas@verge.net.au>
References: <1388114048-3630-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140106082003.GS24653@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 27, 2013 at 12:14:08PM +0900, Simon Horman wrote:
> __initconst must be used instead of __initdata for
> const init definitions.
> 
> This problem was introduced by 3d5de27174955702 ("mach-shmobile: Emma
> Mobile EV2 DT support V3") in v3.4-rc7.

I have queued this up.

> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/setup-emev2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
> index c8f2a1a..c71d667 100644
> --- a/arch/arm/mach-shmobile/setup-emev2.c
> +++ b/arch/arm/mach-shmobile/setup-emev2.c
> @@ -58,7 +58,7 @@ static void __init emev2_add_standard_devices_dt(void)
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> -static const char *emev2_boards_compat_dt[] __initdata = {
> +static const char *emev2_boards_compat_dt[] __initconst = {
>  	"renesas,emev2",
>  	NULL,
>  };
> -- 
> 1.8.4
> 
