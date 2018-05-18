From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 18 May 2018 09:56:18 -0700
Subject: [PATCH 2/2] pwm: stm32: initialize raw local variables
In-Reply-To: <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <53e327ba-10c0-618c-edf4-1e1b528527c7@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2018 08:24 AM, Fabrice Gasnier wrote:
> This removes build warning when COMPILE_TEST=y and MFD_STM32_TIMERS=n
> in drivers/pwm/pwm-stm32.c. In function 'stm32_pwm_capture' 'raw_prd' and
> 'raw_dty' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 60bfc07..09383c6 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -170,7 +170,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned long long prd, div, dty;
>  	unsigned long rate;
>  	unsigned int psc = 0, icpsc, scale;
> -	u32 raw_prd, raw_dty;
> +	u32 raw_prd = 0, raw_dty = 0;
>  	int ret = 0;
>  
>  	mutex_lock(&priv->lock);
> 


-- 
~Randy
