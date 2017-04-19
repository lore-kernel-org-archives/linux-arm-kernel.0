From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 19 Apr 2017 14:21:23 -0700
Subject: [PATCH] soc: brcmstb: enable drivers for ARM64 also
In-Reply-To: <20170419201811.70246-1-code@mmayer.net>
References: <20170419201811.70246-1-code@mmayer.net>
Message-ID: <4bd9f3b3-4c2d-2da2-f728-8edb466f9bb9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2017 01:18 PM, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> We enable the BRCMSTB SoC drivers not only for ARM, but also ARM64.

This looks fine, can you also put add || BMIPS_GENERIC in there since
the driver is also used for these platforms?

We may also want a || COMPILE_TEST just to improve build coverage.

Thanks!

> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/soc/bcm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
> index a39b0d5..b3834b9 100644
> --- a/drivers/soc/bcm/Kconfig
> +++ b/drivers/soc/bcm/Kconfig
> @@ -11,7 +11,7 @@ config RASPBERRYPI_POWER
>  
>  config SOC_BRCMSTB
>  	bool "Broadcom STB SoC drivers"
> -	depends on ARM
> +	depends on ARM || ARM64
>  	select SOC_BUS
>  	help
>  	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
> 


-- 
Florian
