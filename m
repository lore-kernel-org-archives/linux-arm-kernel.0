From: joe@perches.com (Joe Perches)
Date: Sat, 16 Sep 2017 12:33:51 -0700
Subject: [PATCH] i2c: i2c-stm32f7: make structure stm32f7_setup static
In-Reply-To: <20170916113308.25534-1-colin.king@canonical.com>
References: <20170916113308.25534-1-colin.king@canonical.com>
Message-ID: <1505590431.16316.9.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-09-16 at 12:33 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The structure stm32f7_setup is local to the source and does not need
> to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'stm32f7_setup' was not declared. Should it be static?
[]
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
[]
> @@ -265,7 +265,7 @@ static struct stm32f7_i2c_spec i2c_specs[] = {
>  	},
>  };
>  
> -struct stm32f7_i2c_setup stm32f7_setup = {
> +static struct stm32f7_i2c_setup stm32f7_setup = {

better to use static const

>  	.rise_time = STM32F7_I2C_RISE_TIME_DEFAULT,
>  	.fall_time = STM32F7_I2C_FALL_TIME_DEFAULT,
>  	.dnf = STM32F7_I2C_DNF_DEFAULT,
