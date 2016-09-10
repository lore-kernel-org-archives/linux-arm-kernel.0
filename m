From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 10 Sep 2016 15:54:11 +0200
Subject: [PATCH -next] pwm: meson: Fix missing spin_lock_init()
In-Reply-To: <1473489518-17981-1-git-send-email-weiyj.lk@gmail.com>
References: <1473489518-17981-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <57D41083.3060109@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/09/2016 08:38, Wei Yongjun a ?crit :
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The driver allocates the spinlock but not initialize it.
> Use spin_lock_init() on it to initialize it correctly.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pwm/pwm-meson.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index bfbbe7f..778d088 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -465,6 +465,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(meson->base))
>  		return PTR_ERR(meson->base);
>  
> +	spin_lock_init(&meson->lock);
>  	meson->chip.dev = &pdev->dev;
>  	meson->chip.ops = &meson_pwm_ops;
>  	meson->chip.base = -1;
> 

Thanks for the fix, but it was already posted earlier by Axel Lin <axel.lin@ingics.com>

Thierry will decide which one to merge.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
