From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jun 2012 06:19:19 -0700
Subject: [PATCH] arm: OMAP depends on MMU
In-Reply-To: <1339116651-18051-1-git-send-email-mathieu.poirier@linaro.org>
References: <1339116651-18051-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20120620131918.GJ12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* mathieu.poirier at linaro.org <mathieu.poirier@linaro.org> [120607 17:55]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is no way to build OMAP kernels without an MMU
> at this point because of dependencies on MMU-only functions.
> 
> As long as nobody is interested in fixing this, let's just disable
> this platforms for nommu kernels.

Thanks, applying into fixes non-critical.

Tony

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 84449dd..4b1fc0d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -934,6 +934,7 @@ config ARCH_DAVINCI
>  
>  config ARCH_OMAP
>  	bool "TI OMAP"
> +	depends on MMU
>  	select HAVE_CLK
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARCH_HAS_CPUFREQ
> -- 
> 1.7.5.4
> 
