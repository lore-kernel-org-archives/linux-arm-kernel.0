From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 2 Sep 2015 23:12:29 +0900
Subject: [PATCHv2 2/2] ARM: exynos_defconfig: Enable CONFIG_LEDS_PWM for
 Odroid-XU3
In-Reply-To: <1433696621-4763-2-git-send-email-linux.amoon@gmail.com>
References: <1433696621-4763-1-git-send-email-linux.amoon@gmail.com>
 <1433696621-4763-2-git-send-email-linux.amoon@gmail.com>
Message-ID: <55E703CD.3060207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 08.06.2015 o 02:03, Anand Moon pisze:
> Enable CONFIG_LEDS_PWM amd CONFIG_LEDS_TRIGGER_HEARTBEAT for
> Odroid-XU3 board.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Dear Anand,

There was some confusion for this patch (mixed v3 and v2) so overall it
slipped through fingers.

Can you please:
1. Rebase and resend.
2. Enable them as built-ins, not modules. For exynos_defconfig
everything is built-in which makes easier to test on various boards.
3. Enable LEDS_GPIO. I don't know why it disappeared...

Best regards,
Krzysztof


> ---
>  arch/arm/configs/exynos_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 1b7253b..2bbdf80 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -165,6 +165,12 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_IDMAC=y
>  CONFIG_MMC_DW_EXYNOS=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=m
> +CONFIG_LEDS_PWM=m
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=m
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=m
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_MAX77686=y
>  CONFIG_RTC_DRV_MAX77802=y
> 
