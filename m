From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 29 May 2014 08:37:13 +0100
Subject: [PATCH 4/5] mfd: axp209x: Drop the parent supplies field
In-Reply-To: <1401297069-7423-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
 <1401297069-7423-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140529073713.GF1954@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Now that the regulator code get its parent supplies purely from the DT, we can
> drop the parent supplies resources in the MFD driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 11 -----------
>  1 file changed, 11 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 5734f8c82abf..6231adbb295d 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -140,15 +140,6 @@ static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
>  	.init_ack_masked	= true,
>  };
>  
> -static const char * axp20x_supplies[] = {
> -	"acin",
> -	"vin2",
> -	"vin3",
> -	"ldo24in",
> -	"ldo3in",
> -	"ldo5in",
> -};
> -
>  static struct mfd_cell axp20x_cells[] = {
>  	{
>  		.name			= "axp20x-pek",
> @@ -156,8 +147,6 @@ static struct mfd_cell axp20x_cells[] = {
>  		.resources		= axp20x_pek_resources,
>  	}, {
>  		.name			= "axp20x-regulator",
> -		.parent_supplies	= axp20x_supplies,
> -		.num_parent_supplies	= ARRAY_SIZE(axp20x_supplies),
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
