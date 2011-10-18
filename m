From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Oct 2011 09:08:55 +0900
Subject: [PATCH v2] gpio/samsung: Complain loudly if we don't know the SoC
In-Reply-To: <1318887379-5158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1318887379-5158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <00b601cc8d2a$20d20780$62761680$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> If we don't know the SoC type then we won't add any chips which is rather
> unfortunate as neither GPIO nor pinmux APIs will work, breaking lots of
> different subsystems. Logging at least provides a hint to the user as to
> what's gone wrong.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/gpio/gpio-samsung.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
> index 479edc3..8662518 100644
> --- a/drivers/gpio/gpio-samsung.c
> +++ b/drivers/gpio/gpio-samsung.c
> @@ -2486,6 +2486,9 @@ static __init int samsung_gpiolib_init(void)
>  		s5p_register_gpioint_bank(IRQ_GPIO_XA, 0,
> IRQ_GPIO1_NR_GROUPS);
>  		s5p_register_gpioint_bank(IRQ_GPIO_XB,
> IRQ_GPIO1_NR_GROUPS, IRQ_GPIO2_NR_GROUPS);
>  #endif
> +	} else {
> +		WARN(1, "Unknown SoC in gpio-samsung, no GPIOs added\n");
> +		return -ENODEV;
>  	}
> 
>  	return 0;
> --
> 1.7.6.3

Looks ok to me, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
