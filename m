From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Mon, 18 Sep 2017 11:18:02 +0200
Subject: [PATCH][V2] i2c: i2c-stm32f7: make structure stm32f7_setup static
 const
In-Reply-To: <20170918081539.26512-1-colin.king@canonical.com>
References: <20170918081539.26512-1-colin.king@canonical.com>
Message-ID: <3684ee87-f9ca-85e8-302a-7f681c58fdd5@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2017 10:15 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The structure stm32f7_setup is local to the source and does not need
> to be in global scope, make it static const.
> 
> Cleans up sparse warning:
> symbol 'stm32f7_setup' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 47c67b0ca896..3eae4fc96884 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -265,7 +265,7 @@ static struct stm32f7_i2c_spec i2c_specs[] = {
>  	},
>  };
>  
> -struct stm32f7_i2c_setup stm32f7_setup = {
> +static const struct stm32f7_i2c_setup stm32f7_setup = {
>  	.rise_time = STM32F7_I2C_RISE_TIME_DEFAULT,
>  	.fall_time = STM32F7_I2C_FALL_TIME_DEFAULT,
>  	.dnf = STM32F7_I2C_DNF_DEFAULT,
> 

Acked-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
