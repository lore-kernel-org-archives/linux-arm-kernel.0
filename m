From: joe@perches.com (Joe Perches)
Date: Thu, 22 May 2014 08:59:33 -0700
Subject: [PATCH] mfd: axp20x: Remove unnecessary const qualifier from
 axp20x_supplies[]
In-Reply-To: <1400750311-15323-2-git-send-email-lee.jones@linaro.org>
References: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
 <1400750311-15323-2-git-send-email-lee.jones@linaro.org>
Message-ID: <1400774373.21099.1.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-05-22 at 10:18 +0100, Lee Jones wrote:
> drivers/mfd/axp20x.c:159:3:
>   warning: initialization discards ?const? qualifier from pointer target type
>    .parent_supplies = axp20x_supplies,
[]
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
[]
> @@ -140,7 +140,7 @@ static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
>  	.init_ack_masked	= true,
>  };
>  
> -static const char * const axp20x_supplies[] = {
> +static const char * axp20x_supplies[] = {
>  	"acin",
>  	"vin2",
>  	"vin3",

Perhaps you're doing this the wrong way round.
Maybe this definition should change.

include/linux/mfd/core.h:       const char              **parent_supplies;
