From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 13 Jan 2015 13:56:13 +0100
Subject: [PATCH] Asoc: sam9x5_wm8731: depend on ARCH_AT91 instead of
 SOC_AT91SAM9X5
In-Reply-To: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54B515ED.9080406@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/01/2015 13:27, Alexandre Belloni a ?crit :
> The SOC_AT91SAM9X5 option is going to be removed, only depend on ARCH_AT91 like
> for the other drivers.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  sound/soc/atmel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index fb3878312bf8..1579e994acf8 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -45,7 +45,7 @@ config SND_ATMEL_SOC_WM8904
>  
>  config SND_AT91_SOC_SAM9X5_WM8731
>  	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
> -	depends on ATMEL_SSC && SND_ATMEL_SOC && SOC_AT91SAM9X5
> +	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC
>  	select SND_ATMEL_SOC_SSC
>  	select SND_ATMEL_SOC_DMA
>  	select SND_SOC_WM8731
> 


-- 
Nicolas Ferre
