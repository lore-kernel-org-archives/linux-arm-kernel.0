From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Nov 2014 12:57:44 -0200
Subject: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
In-Reply-To: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
References: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOMZO5Dz-vz=zV1r3O_Pv0=WS+_Pk=kaBiK1hb2ttxy_BPwLnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 11:48 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Prevents build warning:
>
> st_thermal.c:278:12:
>     warning: ?st_thermal_suspend? defined but not used [-Wunused-function]
> st_thermal.c:286:12:
>     warning: ?st_thermal_resume? defined but not used [-Wunused-function]
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/thermal/st/st_thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
> index 90163b3..9841488 100644
> --- a/drivers/thermal/st/st_thermal.c
> +++ b/drivers/thermal/st/st_thermal.c
> @@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL_GPL(st_thermal_unregister);
>
> +#ifdef CONFIG_PM

Actually this should be #ifdef CONFIG_PM_SLEEP instead
