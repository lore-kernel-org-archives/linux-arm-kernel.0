From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 20 Apr 2017 07:14:26 +0300
Subject: [PATCH v2] soc: brcmstb: enable drivers for ARM64 and BMIPS
In-Reply-To: <20170419225040.71650-1-code@mmayer.net>
References: <20170419225040.71650-1-code@mmayer.net>
Message-ID: <20170420041426.p6xfmnztel2d7hpa@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Wed, Apr 19, 2017 at 03:50:40PM -0700, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> We enable the BRCMSTB SoC drivers not only for ARM, but also ARM64 and
> BMIPS.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
> 
> I used (COMPILE_TEST & OF) as condition like Raspberry Pi, since we
> have of_* calls in our code, too.

All of_* calls under drivers/soc/bcm/ either have empty implementations for 
the !CONFIG_OF case, or call only such routines. The RPi OF condition is most 
likely not needed as well.

baruch

> Changes since v1:
>   - Add BMIPS
>   - Add COMPILE_TEST
> 
>  drivers/soc/bcm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
> index a39b0d58ddd0..9463d6709909 100644
> --- a/drivers/soc/bcm/Kconfig
> +++ b/drivers/soc/bcm/Kconfig
> @@ -11,7 +11,7 @@ config RASPBERRYPI_POWER
>  
>  config SOC_BRCMSTB
>  	bool "Broadcom STB SoC drivers"
> -	depends on ARM
> +	depends on ARM || ARM64 || BMIPS_GENERIC || (COMPILE_TEST && OF)
>  	select SOC_BUS
>  	help
>  	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
