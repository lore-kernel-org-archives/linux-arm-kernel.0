From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 29 Sep 2015 16:13:46 -0400 (EDT)
Subject: [PATCH 1/1] Disable CONFIG_UACCESS_WITH_MEMCPY in Atmel config.
In-Reply-To: <1443556987-2788-1-git-send-email-jc@eclis.ch>
References: <1443556987-2788-1-git-send-email-jc@eclis.ch>
Message-ID: <alpine.LFD.2.20.1509291613080.11346@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Sep 2015, jc at eclis.ch wrote:

> From: Jean-Christian de Rivaz <jc@eclis.ch>
> 
> According to Russell King:
> In any case, unless you have a Marvell platform, you should have this
> disabled - it provides a performance boost for Marvell platforms, but
> degrades performance everywhere else.  Please ensure that you disable
> CONFIG_UACCESS_WITH_MEMCPY.
> 
> Signed-off-by: Jean-Christian de Rivaz <jc@eclis.ch>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/configs/at91_dt_defconfig |    2 +-
>  arch/arm/configs/sama5_defconfig   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 090c5b2..1807d7f 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -21,7 +21,7 @@ CONFIG_SOC_SAM_V4_V5=y
>  CONFIG_SOC_AT91RM9200=y
>  CONFIG_SOC_AT91SAM9=y
>  CONFIG_AEABI=y
> -CONFIG_UACCESS_WITH_MEMCPY=y
> +# CONFIG_UACCESS_WITH_MEMCPY is not set
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 31eb951..471e214 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -19,7 +19,7 @@ CONFIG_SOC_SAM_V7=y
>  CONFIG_SOC_SAMA5D3=y
>  CONFIG_SOC_SAMA5D4=y
>  CONFIG_AEABI=y
> -CONFIG_UACCESS_WITH_MEMCPY=y
> +# CONFIG_UACCESS_WITH_MEMCPY is not set
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
> -- 
> 1.7.10.4
> 
> 
