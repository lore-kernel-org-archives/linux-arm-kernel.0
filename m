From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Sep 2011 15:01:38 +0900
Subject: [PATCH 3/5] ARM: S5P64X0: Add pm save/restore functions for GPIO
	banks
In-Reply-To: <1313144787-30666-4-git-send-email-a.kesavan@samsung.com>
References: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
	<1313144787-30666-4-git-send-email-a.kesavan@samsung.com>
Message-ID: <000301cc6d23$9bad71a0$d30854e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> Fix the "no pm for GPIOXX" messages appearing during bootup due
> to missing assignment of save/restore functions for those banks.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  arch/arm/mach-s5p64x0/gpiolib.c  |    1 +
>  drivers/gpio/gpio-plat-samsung.c |    4 +++-
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p64x0/gpiolib.c
b/arch/arm/mach-s5p64x0/gpiolib.c
> index e7fb3b0..76c0924 100644
> --- a/arch/arm/mach-s5p64x0/gpiolib.c
> +++ b/arch/arm/mach-s5p64x0/gpiolib.c
> @@ -467,6 +467,7 @@ static void __init s5p64x0_gpio_add_rbank_4bit2(struct
> s3c_gpio_chip *chip,
>  		chip->chip.direction_input =
s5p64x0_gpiolib_rbank_4bit2_input;
>  		chip->chip.direction_output =
>  					s5p64x0_gpiolib_rbank_4bit2_output;
> +		chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
>  		s3c_gpiolib_add(chip);
>  	}
>  }
> diff --git a/drivers/gpio/gpio-plat-samsung.c
b/drivers/gpio/gpio-plat-samsung.c
> index ef67f19..4f7c387 100644
> --- a/drivers/gpio/gpio-plat-samsung.c
> +++ b/drivers/gpio/gpio-plat-samsung.c
> @@ -200,6 +200,8 @@ void __init samsung_gpiolib_add_4bit2_chips(struct
> s3c_gpio_chip *chip,
>  void __init samsung_gpiolib_add_2bit_chips(struct s3c_gpio_chip *chip,
>  					   int nr_chips)
>  {
> -	for (; nr_chips > 0; nr_chips--, chip++)
> +	for (; nr_chips > 0; nr_chips--, chip++) {
> +		chip->pm = __gpio_pm(&s3c_gpio_pm_2bit);
>  		s3c_gpiolib_add(chip);
> +	}
>  }
> --
> 1.7.4.1

Hi Abhilash,

Since submitted gpio-samsung patch includes above changes, so we can drop
this.

If any problem, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
