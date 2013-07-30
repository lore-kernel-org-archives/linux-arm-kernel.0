From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Jul 2013 10:38:50 +0800
Subject: [PATCH 1/2] ARM: mach-imx: Select ARM_CPU_SUSPEND at ARCH_MXC
 level
In-Reply-To: <1374808656-28609-1-git-send-email-festevam@gmail.com>
References: <1374808656-28609-1-git-send-email-festevam@gmail.com>
Message-ID: <20130730023848.GB19715@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 12:17:35AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Instead of selecting ARM_CPU_SUSPEND only for mx6, we can select it for 
> all SoCs from the ARCH_MXC family.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index bb1cc9e..1cc219f 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -1,5 +1,6 @@
>  config ARCH_MXC
>  	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
> +	select ARM_CPU_SUSPEND if PM

This should be put after ARCH_REQUIRE_GPIOLIB line.  I fixed it up and
applied both patches.

Shawn

>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_PATCH_PHYS_VIRT
>  	select AUTO_ZRELADDR if !ZBOOT_ROM
