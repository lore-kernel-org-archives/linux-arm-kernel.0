From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 22:29:33 +0200
Subject: [PATCH 1/3] ARM: digicolor: select pinctrl/gpio driver
In-Reply-To: <0c3f348274ea14bc82c0e4f7b240be650624fb0d.1444735169.git.baruch@tkos.co.il>
References: <cover.1444735169.git.baruch@tkos.co.il>
 <0c3f348274ea14bc82c0e4f7b240be650624fb0d.1444735169.git.baruch@tkos.co.il>
Message-ID: <19934450.tsPWutDox2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 14:28:02 Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/mach-digicolor/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-digicolor/Kconfig b/arch/arm/mach-digicolor/Kconfig
> index 4f36d8d2bc57..fc65b0f1db48 100644
> --- a/arch/arm/mach-digicolor/Kconfig
> +++ b/arch/arm/mach-digicolor/Kconfig
> @@ -1,7 +1,10 @@
>  config ARCH_DIGICOLOR
>  	bool "Conexant Digicolor SoC Support"
>  	depends on ARCH_MULTI_V7
> +	select ARCH_REQUIRE_GPIOLIB
>  	select CLKSRC_MMIO
>  	select DIGICOLOR_TIMER
>  	select GENERIC_IRQ_CHIP
>  	select MFD_SYSCON
> +	select PINCTRL
> +	select PINCTRL_DIGICOLOR
> 

Applied to next/soc, but please add a patch description even for trivial
patches like this in the future. A good changelog text here would explain
why this wasn't done in the past but is necessary now.

Thanks,

	Arnd
