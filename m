From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 07:02:27 +0800
Subject: [PATCH] ARM: imx: allow support to be disabled
In-Reply-To: <1350939621-2892-1-git-send-email-swarren@wwwdotorg.org>
References: <1350939621-2892-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121022230224.GA3253@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 03:00:21PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Since ARCH_MXC's Kconfig option has no string name, the user is never
> presented with an option to enable/disable this setting. Rather, it is
> automatically enabled based on the conditions in the def_bool entry.
> 
> Add a string, so that the user gets to choose whether to enable ARCH_MXC,
> and rename the i.MX options menu so that it doesn't clash. Also, change
> from "def_bool y" to "bool" to be more consistent with other machines.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks for the patch, Stephen.  I have queued a similar fix [1] from
Fabio.  Hopefully, arm-soc folks will apply it soon.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/194310

> ---
> Note that if Tegra and i.MX support are enabled at the same time, then
> the build will fail since both Tegra's and i.MX's head.S define symbol
> v7_invalidate_l1. shmobile appears to have the same conflict. Note that
> patches to port Tegra to ARCH_MULTI aren't yet in linux-next, but I can
> point anyone who's interested at my github tree.
> ---
>  arch/arm/mach-imx/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 892631f..5cc2417 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_MXC
> -	def_bool y if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
> +	bool "Freescale i.MX support" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_PATCH_PHYS_VIRT
>  	select AUTO_ZRELADDR if !ZBOOT_ROM
> @@ -13,7 +13,7 @@ config ARCH_MXC
>  	help
>  	  Support for Freescale MXC/iMX-based family of processors
>  
> -menu "Freescale i.MX support"
> +menu "Freescale i.MX options"
>  	depends on ARCH_MXC
>  
>  config MXC_IRQ_PRIOR
> -- 
> 1.7.0.4
> 
