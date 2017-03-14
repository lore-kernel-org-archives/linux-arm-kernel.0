From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 14 Mar 2017 14:00:59 +0000
Subject: [PATCH] mfd: stm32-timers: fix max register
In-Reply-To: <1487145872-1212-1-git-send-email-fabrice.gasnier@st.com>
References: <1487145872-1212-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170314140059.6bmxavtlsjuvoxnw@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Feb 2017, Fabrice Gasnier wrote:

> STM32 timers register bank size is 0x400. Fix regmap max_register.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/mfd/stm32-timers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index 192cbb6..2182f00 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -15,7 +15,7 @@
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = sizeof(u32),
> -	.max_register = 0x400,
> +	.max_register = 0x3fc,
>  };
>  
>  static void stm32_timers_get_arr_size(struct stm32_timers *ddata)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
