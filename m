From: robh@kernel.org (Rob Herring)
Date: Thu, 2 Mar 2017 10:29:31 -0600
Subject: [PATCH 3/4 v3] ARM: gemini: select MIGHT_HAVE_PCI
In-Reply-To: <20170227190720.31409-3-linus.walleij@linaro.org>
References: <20170227190720.31409-1-linus.walleij@linaro.org>
 <20170227190720.31409-3-linus.walleij@linaro.org>
Message-ID: <20170302162931.tyngslqsr2axy5qx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 08:07:19PM +0100, Linus Walleij wrote:
> As we have a PCI driver for the Gemini, we should select
> MIGHT_HAVE_PCI.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2->v3:
> - No changes
> 
> PCI maintainers: this is FYI only, I will funnel this to the ARM
> SoC tree once we are done with the PCI driver.
> ---
>  arch/arm/mach-gemini/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
> index a5ee5fbab796..21f89a4c16fe 100644
> --- a/arch/arm/mach-gemini/Kconfig
> +++ b/arch/arm/mach-gemini/Kconfig
> @@ -6,6 +6,7 @@ menuconfig ARCH_GEMINI
>  	select FTTMR010_TIMER
>  	select GPIO_GEMINI
>  	select GPIOLIB
> +	select MIGHT_HAVE_PCI

Doesn't Multi-platform do this for you? If not, IMO, we should do that 
or kill this option. We don't do an option like this for I2C, SPI, 
display, anything else (well, except GPIOLIB ;)).

>  	select POWER_RESET
>  	select POWER_RESET_SYSCON
>  	select SERIAL_OF_PLATFORM
> -- 
> 2.9.3
> 
