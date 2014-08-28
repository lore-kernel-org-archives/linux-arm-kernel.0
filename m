From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 28 Aug 2014 10:36:39 +0200
Subject: [PATCH v9 4/5] rtc: max77686: Remove unneded info log
In-Reply-To: <1408350877-15921-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1408350877-15921-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408350877-15921-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1409214999.20020.0.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-08-18 at 10:34 +0200, Javier Martinez Canillas wrote:
> If devm_rtc_device_register() fails a dev_err() is already
> reported so there is no need to do an additional dev_info().
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

> ---
>  drivers/rtc/rtc-max77686.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 55396bb..b177ba1 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -457,8 +457,6 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>  					&max77686_rtc_ops, THIS_MODULE);
>  
>  	if (IS_ERR(info->rtc_dev)) {
> -		dev_info(&pdev->dev, "%s: fail\n", __func__);
> -
>  		ret = PTR_ERR(info->rtc_dev);
>  		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
>  		if (ret == 0)
