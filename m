From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 07 Apr 2014 13:48:12 +0100
Subject: [PATCH v3] arm: Fix DEBUG_LL for multi-platform kernels (without
 PL01X)
In-Reply-To: <1396626102-13991-1-git-send-email-daniel.thompson@linaro.org>
References: <1396622847-12718-1-git-send-email-daniel.thompson@linaro.org>
 <1396626102-13991-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <53429E8C.3000403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/14 16:41, Daniel Thompson wrote:
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 0531da8..7e19c94 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -989,12 +989,7 @@ config DEBUG_LL_INCLUDE
>  
>  # Compatibility options for PL01x
>  config DEBUG_UART_PL01X
> -	def_bool ARCH_EP93XX || \
> -		ARCH_INTEGRATOR || \
> -		ARCH_SPEAR3XX || \
> -		ARCH_SPEAR6XX || \
> -		ARCH_SPEAR13XX || \
> -		ARCH_VERSATILE
> +	bool

NACK!

Sorry. I've got my posting-a-patch and my testing in the wrong order!

This patch regresses the build for (at least) the versatile. Expect v4
in due course (after I have improved my build automation).


Daniel.
