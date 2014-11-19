From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 19 Nov 2014 15:43:30 +0100
Subject: [STLinux Kernel] [PATCH] thermal: sti: Ignore suspend/resume
 functions when !PM
In-Reply-To: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
References: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
Message-ID: <546CAC92.3020504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/19/2014 02:48 PM, Lee Jones wrote:
> Prevents build warning:
>
> st_thermal.c:278:12:
>      warning: ?st_thermal_suspend? defined but not used [-Wunused-function]
> st_thermal.c:286:12:
>      warning: ?st_thermal_resume? defined but not used [-Wunused-function]
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime

> ---
>   drivers/thermal/st/st_thermal.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
> index 90163b3..9841488 100644
> --- a/drivers/thermal/st/st_thermal.c
> +++ b/drivers/thermal/st/st_thermal.c
> @@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_device *pdev)
>   }
>   EXPORT_SYMBOL_GPL(st_thermal_unregister);
>   
> +#ifdef CONFIG_PM
>   static int st_thermal_suspend(struct device *dev)
>   {
>   	struct platform_device *pdev = to_platform_device(dev);
> @@ -305,6 +306,8 @@ static int st_thermal_resume(struct device *dev)
>   
>   	return 0;
>   }
> +#endif
> +
>   SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_resume);
>   EXPORT_SYMBOL_GPL(st_thermal_pm_ops);
>   
