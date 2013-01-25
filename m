From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 25 Jan 2013 14:51:30 +0100
Subject: [PATCH v2 2/3] pwm: Add can_sleep property to drivers
In-Reply-To: <1359121471-21457-3-git-send-email-florian.vaussard@epfl.ch>
References: <1359121471-21457-1-git-send-email-florian.vaussard@epfl.ch>
 <1359121471-21457-3-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <51028DE2.1050904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2013 02:44 PM, Florian Vaussard wrote:
> Calls to PWM drivers connected through I2C can sleep.
> Use the new can_sleep property.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  drivers/pwm/pwm-twl-led.c |    1 +
>  drivers/pwm/pwm-twl.c     |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
> index 9dfa0f3..6261193 100644
> --- a/drivers/pwm/pwm-twl-led.c
> +++ b/drivers/pwm/pwm-twl-led.c
> @@ -300,6 +300,7 @@ static int twl_pwmled_probe(struct platform_device *pdev)
>  
>  	twl->chip.dev = &pdev->dev;
>  	twl->chip.base = -1;
> +	twl->chip.can_sleep = 1;
>  
>  	mutex_init(&twl->mutex);
>  
> diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
> index e65db95..4e56cd8 100644
> --- a/drivers/pwm/pwm-twl.c
> +++ b/drivers/pwm/pwm-twl.c
> @@ -315,6 +315,7 @@ static int twl_pwm_probe(struct platform_device *pdev)
>  	twl->chip.dev = &pdev->dev;
>  	twl->chip.base = -1;
>  	twl->chip.npwm = 2;
> +	twl->chip.can_sleep = 1;
>  
>  	mutex_init(&twl->mutex);
>  
> 


-- 
P?ter
