From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 17 Nov 2014 01:29:20 -0500 (EST)
Subject: [PATCH v2] cpu_pm: fix unmet dependency for CPU_PM
In-Reply-To: <1416204764-8912-1-git-send-email-pankaj.dubey@samsung.com>
References: <1416204764-8912-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <alpine.LFD.2.11.1411170128560.11690@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Pankaj Dubey wrote:

> If BL_SWITCHER is enabled but SUSPEND and CPU_IDLE is not enabled
> we are getting following config warning.
> 
> warning: (BL_SWITCHER) selects CPU_PM which has unmet direct
> dependencies (SUSPEND || CPU_IDLE)
> 
> It has been noticed that CPU_PM dependencies in this file are not really
> required so let's remove these dependencies from CPU_PM.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> This patch is second attempt to fix this config issue. Patch v1 and related
> discussion can be found here [1]
> 1: https://lkml.org/lkml/2014/11/14/673
> 
>  kernel/power/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index bbef57f..1eb7da7 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -308,4 +308,3 @@ config PM_GENERIC_DOMAINS_OF
>  
>  config CPU_PM
>  	bool
> -	depends on SUSPEND || CPU_IDLE
> -- 
> 1.7.9.5
> 
> 
