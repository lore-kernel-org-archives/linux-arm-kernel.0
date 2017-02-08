From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 8 Feb 2017 08:49:37 +0530
Subject: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: remove unnecessary
 platform_set_drvdata()
In-Reply-To: <20170207155645.5455-1-weiyj.lk@gmail.com>
References: <20170207155645.5455-1-weiyj.lk@gmail.com>
Message-ID: <20170208031936.GA14503@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-02-17, 15:56, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index c943606..7281a2c 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -878,7 +878,6 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
>  	iounmap(priv->avs_intr_base);
>  unmap_base:
>  	iounmap(priv->base);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return ret;
>  }
> @@ -1042,7 +1041,6 @@ static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
>  	priv = platform_get_drvdata(pdev);
>  	iounmap(priv->base);
>  	iounmap(priv->avs_intr_base);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
