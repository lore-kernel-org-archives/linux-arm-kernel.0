From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue, 19 Apr 2011 12:40:32 +0400
Subject: [PATCH] pxa/hx4700: bq24022 regulator needs to be enabled
In-Reply-To: <E1QAkBF-0003bF-A0@outmx04.plus.net>
References: <E1QAkBF-0003bF-A0@outmx04.plus.net>
Message-ID: <20110419084032.GA30743@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:39 Fri 15 Apr     , Paul Parsons wrote:
> Add REGULATOR_CHANGE_STATUS flag to hx4700 bq24022 regulator. Without this flag the bq24022 cannot be enabled and the battery will not charge.
> 
Ah, so that's why my hx4700 doesn't charges under linux! I noticed
that some time ago, but never found the time to investigate this.
Thanks for finding this out. Will test.

BTW, this should probably go through Eric Miao's PXA tree, so adding him
to CC list.

> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
> --- clean-2.6.38/arch/arm/mach-pxa/hx4700.c	2011-03-15 01:20:32.000000000 +0000
> +++ linux-2.6.38/arch/arm/mach-pxa/hx4700.c	2011-04-15 04:39:04.869989025 +0100
> @@ -711,7 +711,7 @@ static struct regulator_consumer_supply 
>  static struct regulator_init_data bq24022_init_data = {
>  	.constraints = {
>  		.max_uA         = 500000,
> -		.valid_ops_mask = REGULATOR_CHANGE_CURRENT,
> +		.valid_ops_mask = REGULATOR_CHANGE_CURRENT|REGULATOR_CHANGE_STATUS,
>  	},
>  	.num_consumer_supplies  = ARRAY_SIZE(bq24022_consumers),
>  	.consumer_supplies      = bq24022_consumers,
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Best regards,
Dmitry "MAD" Artamonow
