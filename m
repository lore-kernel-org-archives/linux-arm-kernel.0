From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 16 Dec 2016 13:37:56 +0100
Subject: [PATCH] pinctrl: stm32: activate strict mux mode
In-Reply-To: <1481725456-1030-1-git-send-email-gabriel.fernandez@st.com>
References: <1481725456-1030-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <42c18683-6d2e-b717-2863-7f6c405cfa83@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/14/2016 03:24 PM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This activates strict mode muxing for the STM32 pin controllers,
> as these do not allow GPIO and functions to use the same pin
> simultaneously.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  drivers/pinctrl/stm32/pinctrl-stm32.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index efc4371..c983a1e 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -631,6 +631,7 @@ static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
>  	.get_function_groups	= stm32_pmx_get_func_groups,
>  	.set_mux		= stm32_pmx_set_mux,
>  	.gpio_set_direction	= stm32_pmx_gpio_set_direction,
> +	.strict			= true,
>  };
>  
>  /* Pinconf functions */
> 

Hi Gaby

Acked-by: Patrice Chotard <patrice.chotard@st.com>

regards
