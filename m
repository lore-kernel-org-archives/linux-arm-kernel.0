From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 19 Dec 2017 15:53:05 +0100
Subject: [PATCH] pwm: atmel-tcb: Delete an error message for a failed
 memory allocation in atmel_tcb_pwm_probe()
In-Reply-To: <8274c498-1d1b-2ece-365c-98ded714a53c@users.sourceforge.net>
References: <8274c498-1d1b-2ece-365c-98ded714a53c@users.sourceforge.net>
Message-ID: <6d607786-4c1b-0949-0768-1bc0a4749fd5@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/12/2017 at 19:00, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 15 Dec 2017 18:55:11 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.

Can you point which coccinelle script highlited this issue?

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pwm/pwm-atmel-tcb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index acd3ce8ecf3f..4fb1be246c44 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -401,7 +401,6 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>  	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
>  	if (tcbpwm == NULL) {
>  		err = -ENOMEM;
> -		dev_err(&pdev->dev, "failed to allocate memory\n");

We have this in case of error:

atmel-tcb-pwm pwm: failed to allocate memory
atmel-tcb-pwm: probe of pwm failed with error -12

Which is somehow redundant I admit...

>  		goto err_free_tc;
>  	}
>  
> 


-- 
Nicolas Ferre
