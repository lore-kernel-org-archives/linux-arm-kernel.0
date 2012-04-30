From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Apr 2012 17:20:46 -0600
Subject: [PATCH] ARM: disable SUSPEND/ARCH_SUSPEND_POSSIBLE for ARCH_TEGRA
In-Reply-To: <1335381650-7666-1-git-send-email-swarren@wwwdotorg.org>
References: <1335381650-7666-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4F9F1E4E.4020604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 01:20 PM, Stephen Warren wrote:
> Tegra doesn't yet support system sleep. Explicitly disable support
> for this feature in Kconfig.

Russell, Arnd, Olof, should this go through the ARM patch tracker, or
should I just take it through the Tegra tree? Thanks.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

>  config ARCH_SUSPEND_POSSIBLE
> -	depends on !ARCH_S5PC100
> +	depends on !ARCH_S5PC100 && !ARCH_TEGRA
>  	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
>  		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE
>  	def_bool y
