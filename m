From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Sep 2013 00:50:19 +0200
Subject: [PATCH] ARM: mxs: stub out mxs_pm_init for !CONFIG_PM
In-Reply-To: <2964094.prhBouhISv@wuerfel>
References: <2964094.prhBouhISv@wuerfel>
Message-ID: <201309300050.20047.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

> When building a kernel without CONFIG_PM, we get a link
> error from referencing mxs_pm_init in the machine
> descriptor. This defines a macro to NULL for that case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
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

Can you please pick this patch for 3.10 stable? It fixes a build issue on 
i.MX23/i.MX28 in case CONFIG_PM is not enabled.

Patchwork link: http://patchwork.ozlabs.org/patch/253324/

Upstream GIT: 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/mach-
mxs/pm.h?id=7a9caf59f60e55a8caf96f856713bd0ef0cc25a7

Thank you!

Best regards,
Marek Vasut
