From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 20 Apr 2016 09:47:05 -0400
Subject: [PATCH 1/3] i2c: s3c2410: Add missing clock unprepare on probe()
 error path
In-Reply-To: <1461144292-22141-1-git-send-email-k.kozlowski@samsung.com>
References: <1461144292-22141-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <57178859.8040801@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/20/2016 05:24 AM, Krzysztof Kozlowski wrote:
> If during probe() the s3c24xx_i2c_init() failed, the clock was left in
> disabled but prepared state.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 362a6de54833..e9658af36f2e 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -1200,6 +1200,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  	clk_disable(i2c->clk);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "I2C controller init failed\n");
> +		clk_unprepare(i2c->clk);
>  		return ret;
>  	}
>  	/* find the IRQ for this unit (note, this relies on the init call to
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
