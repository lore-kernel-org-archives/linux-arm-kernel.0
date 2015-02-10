From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 10 Feb 2015 19:59:40 +0900
Subject: [patch] PM / devfreq: event: testing the wrong variable
In-Reply-To: <20150210103547.GA18481@mwanda>
References: <20150210103547.GA18481@mwanda>
Message-ID: <54D9E49C.80105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2015 07:35 PM, Dan Carpenter wrote:
> There is a typo here so we test "edev" but we intended to test
> "edev[i]".
> 
> Fixes: f262f28c1470 ('PM / devfreq: event: Add devfreq_event class')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 135be0a..ad83473 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -327,8 +327,8 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < info->num_events; i++) {
>  		edev[i] = devm_devfreq_event_add_edev(&pdev->dev, &desc[i]);
> -		if (IS_ERR(edev)) {
> -			ret = PTR_ERR(edev);
> +		if (IS_ERR(edev[i])) {
> +			ret = PTR_ERR(edev[i]);
>  			dev_err(&pdev->dev,
>  				"failed to add devfreq-event device\n");
>  			goto err;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

But,
This patch has not yet merged to linux.git (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git).
After releasing Linux 3.20-rc1, this patch will be handled.

Thanks,
Chanwoo Choi
