From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 15:04:48 +0800
Subject: [PATCH] ARM: mxs: stub out mxs_pm_init for !CONFIG_PM
In-Reply-To: <2964094.prhBouhISv@wuerfel>
References: <2964094.prhBouhISv@wuerfel>
Message-ID: <20130624070446.GF26254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 01:30:17AM +0200, Arnd Bergmann wrote:
> When building a kernel without CONFIG_PM, we get a link
> error from referencing mxs_pm_init in the machine
> descriptor. This defines a macro to NULL for that case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> 
> diff --git a/arch/arm/mach-mxs/pm.h b/arch/arm/mach-mxs/pm.h
> index f57e7cd..09d77b0 100644
> --- a/arch/arm/mach-mxs/pm.h
> +++ b/arch/arm/mach-mxs/pm.h
> @@ -9,6 +9,10 @@
>  #ifndef __ARCH_MXS_PM_H
>  #define __ARCH_MXS_PM_H
>  
> +#ifdef CONFIG_PM
>  void mxs_pm_init(void);
> +#else
> +#define mxs_pm_init NULL
> +#endif
>  
>  #endif
> 
