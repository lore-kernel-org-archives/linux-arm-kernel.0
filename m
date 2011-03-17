From: khilman@ti.com (Kevin Hilman)
Date: Thu, 17 Mar 2011 14:43:31 -0700
Subject: [PATCH] OMAP4: PM: remove redundant #ifdef CONFIG_PM
In-Reply-To: <1299987443-27275-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sun, 13 Mar 2011 09:07:23 +0530")
References: <1299987443-27275-1-git-send-email-nm@ti.com>
Message-ID: <878vwdv2ws.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> pm44xx.c is built only when CONFIG_PM is setup,
> remove redundant CONFIG_PM check.
>
> This also fixes:
> https://bugzilla.kernel.org/show_bug.cgi?id=25022
>
> Reported-by: Martin Etti <ettl.martin@gmx.de>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing for 2.6.39-rc fixes cycle (branch: for_2.6.39/pm-fixes)

Kevin

> ---
>  arch/arm/mach-omap2/pm44xx.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 76cfff2..59a870b 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -105,13 +105,11 @@ static int __init omap4_pm_init(void)
>  
>  	pr_err("Power Management for TI OMAP4.\n");
>  
> -#ifdef CONFIG_PM
>  	ret = pwrdm_for_each(pwrdms_setup, NULL);
>  	if (ret) {
>  		pr_err("Failed to setup powerdomains\n");
>  		goto err2;
>  	}
> -#endif
>  
>  #ifdef CONFIG_SUSPEND
>  	suspend_set_ops(&omap_pm_ops);
