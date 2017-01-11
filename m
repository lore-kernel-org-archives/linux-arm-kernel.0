From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 11 Jan 2017 14:06:01 -0300
Subject: [PATCH] usb: dwc3 dwc3_exynos_probe() change goto labels to
 meaningful names
In-Reply-To: <20170111164537.2981-1-shuahkh@osg.samsung.com>
References: <20170111164537.2981-1-shuahkh@osg.samsung.com>
Message-ID: <d32213e3-98c8-6c8c-231c-53aaba6468ff@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On 01/11/2017 01:45 PM, Shuah Khan wrote:
> Change goto labels to meaningful names from a series of errNs.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index f7421c2..ea50f74 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -147,53 +147,53 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
>  	if (IS_ERR(exynos->vdd33)) {
>  		ret = PTR_ERR(exynos->vdd33);
> -		goto err2;
> +		goto vdd33_err;
>  	}

I think it's better to use as labels what will be done in the error path
rather than what failed. IOW, "disable_axius_clk" or "disable_clks" are
more clear than vdd33_err for me, since can give you an idea of what will
happen in the error path.

But I don't have a strong opinion and your naming is an improvement over
the current one, so:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
