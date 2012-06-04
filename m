From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Jun 2012 00:40:23 -0700
Subject: [PATCH] ARM: OMAP4: hwspinlocks_init() should be static
In-Reply-To: <1336914919-20032-1-git-send-email-ohad@wizery.com>
References: <1336914919-20032-1-git-send-email-ohad@wizery.com>
Message-ID: <20120604074022.GX12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [120513 06:19]:
> Sparse found out that hwspinlocks_init() wasn't marked static,
> and it should've been.

Looks like this already got fixed by Paul's commit 8c3d4534.

Regards,

Tony
 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  arch/arm/mach-omap2/hwspinlock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
> index 454dfce..8763c85 100644
> --- a/arch/arm/mach-omap2/hwspinlock.c
> +++ b/arch/arm/mach-omap2/hwspinlock.c
> @@ -28,7 +28,7 @@ static struct hwspinlock_pdata omap_hwspinlock_pdata __initdata = {
>  	.base_id = 0,
>  };
>  
> -int __init hwspinlocks_init(void)
> +static int __init hwspinlocks_init(void)
>  {
>  	int retval = 0;
>  	struct omap_hwmod *oh;
> -- 
> 1.7.5.4
> 
