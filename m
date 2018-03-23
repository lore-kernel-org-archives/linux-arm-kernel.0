From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 23 Mar 2018 16:22:26 +0100
Subject: [RESEND PATCH 2/3] pwm: stm32: LPTimer: use 3 cells xlate
In-Reply-To: <1519392965-28235-3-git-send-email-fabrice.gasnier@st.com>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
 <1519392965-28235-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <d23f866b-67af-4e5b-14aa-a2c5a0a499ec@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2018 02:36 PM, Fabrice Gasnier wrote:
> From: Gerald Baeza <gerald.baeza@st.com>
> 
> STM32 Low-Power Timer supports generic 3 cells pwm to encode
> PWM number, period and polarity.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 1ac9e43..346b7bd 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -203,6 +203,8 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
>  	priv->chip.dev = &pdev->dev;
>  	priv->chip.ops = &stm32_pwm_lp_ops;
>  	priv->chip.npwm = 1;
> +	priv->chip.of_xlate = of_pwm_xlate_with_flags;
> +	priv->chip.of_pwm_n_cells = 3;
>  
>  	ret = pwmchip_add(&priv->chip);
>  	if (ret < 0)
> 

Hi Thierry, all,

Gentle ping for driver review since DT Bindings has been reviewed by Rob.

Many thanks in advance,
Regards,
Fabrice
