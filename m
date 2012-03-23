From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Mar 2012 11:27:46 -0700
Subject: [PATCH 9/9] ARM: omap: select CPU_FREQ_TABLE where needed
In-Reply-To: <1332522836-29517-10-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-10-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20120323182746.GF9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* mathieu.poirier at linaro.org <mathieu.poirier@linaro.org> [120323 10:17]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The omap platform requires CPU_FREQ_TABLE support to be enabled for its
> CPU_FREQ implementations, so automatically select that when CPU_FREQ
> is enabled.

I think this is also solved now, Kevin might be able to confirm this.

Regards,

Tony
 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  arch/arm/plat-omap/Kconfig |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index aa59f42..1983d16 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -207,6 +207,11 @@ config OMAP_PM_NOOP
>  
>  endchoice
>  
> +config OMAP_CPU_FREQ
> +	def_bool "y"
> +	depends on CPU_FREQ
> +	select CPU_FREQ_TABLE
> +
>  endmenu
>  
>  endif
> -- 
> 1.7.5.4
> 
