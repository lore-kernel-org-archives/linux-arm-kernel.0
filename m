From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Feb 2011 15:25:03 -0500 (EST)
Subject: [PATCH] ARM: Thumb-2: Make CONFIG_OABI_COMPAT depend on
	!CONFIG_THUMB2_KERNEL
In-Reply-To: <1296829210-21259-1-git-send-email-dave.martin@linaro.org>
References: <1296829210-21259-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1102041523340.12104@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Feb 2011, Dave Martin wrote:

> rmk says: "You might as well make OABI_COMPAT depend on !THUMB2_KERNEL.
> OABI userland is useless without FPA support."
> 
> nwfpe doesn't work with Thumb-2 anyway and will probably never get
> ported, so I can't argue with that.
> 
> This patch implements the dependency change.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5cff165..26d45e5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1391,7 +1391,7 @@ config AEABI
>  
>  config OABI_COMPAT
>  	bool "Allow old ABI binaries to run with this kernel (EXPERIMENTAL)"
> -	depends on AEABI && EXPERIMENTAL
> +	depends on AEABI && EXPERIMENTAL && !THUMB2_KERNEL
>  	default y
>  	help
>  	  This option preserves the old syscall interface along with the
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
