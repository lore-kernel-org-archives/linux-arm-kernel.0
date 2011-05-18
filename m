From: khilman@ti.com (Kevin Hilman)
Date: Wed, 18 May 2011 16:40:43 +0200
Subject: [PATCH] OMAP3: pm: Boot message is not an error, remove it
In-Reply-To: <1305710080-2647-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Wed, 18 May 2011 14:44:40 +0530")
References: <1305710080-2647-1-git-send-email-premi@ti.com>
Message-ID: <87wrhors0k.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanjeev,

Sanjeev Premi <premi@ti.com> writes:

> It shows up on the console despite using "silent"
> in the bootargs.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Cc: jhnikula at gmail.com

Thanks!  Adding to queue for 2.6.40 (branch: for_2.6.40/pm-cleanup)

Kevin

> ---
>
>  v2: Changed the subject.
>      Removed the print altogether
>
>  v1: Convert printk to pr_info
>
>  arch/arm/mach-omap2/pm34xx.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 343027f..ba6c524 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -901,8 +901,6 @@ static int __init omap3_pm_init(void)
>  
>  	pm_errata_configure();
>  
> -	printk(KERN_ERR "Power Management for TI OMAP3.\n");
> -
>  	/* XXX prcm_setup_regs needs to be before enabling hw
>  	 * supervised mode for powerdomains */
>  	prcm_setup_regs();
