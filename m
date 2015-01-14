From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 14 Jan 2015 09:46:30 +0800
Subject: [PATCH] Asoc: sam9x5_wm8731: depend on ARCH_AT91 instead of
 SOC_AT91SAM9X5
In-Reply-To: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54B5CA76.3060608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre Belloni,

On 01/13/2015 08:27 PM, Alexandre Belloni wrote:
> The SOC_AT91SAM9X5 option is going to be removed, only depend on ARCH_AT91 like
> for the other drivers.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Bo Shen <voice.shen@atmel.com>

> ---
>   sound/soc/atmel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index fb3878312bf8..1579e994acf8 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -45,7 +45,7 @@ config SND_ATMEL_SOC_WM8904
>
>   config SND_AT91_SOC_SAM9X5_WM8731
>   	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
> -	depends on ATMEL_SSC && SND_ATMEL_SOC && SOC_AT91SAM9X5
> +	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC
>   	select SND_ATMEL_SOC_SSC
>   	select SND_ATMEL_SOC_DMA
>   	select SND_SOC_WM8731
>

Best Regards
Bo Shen
