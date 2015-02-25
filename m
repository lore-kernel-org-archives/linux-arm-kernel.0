From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 25 Feb 2015 11:12:06 -0800
Subject: [PATCH] ARM: omap-device: add missed callback for suspend-to-disk
In-Reply-To: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org>
 (grygorii strashko's message of "Wed, 25 Feb 2015 16:13:50 +0200")
References: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org>
Message-ID: <7hr3tdkdq1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<grygorii.strashko@linaro.org> writes:

> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>
> Add missed callback needed for supporting suspend-to-disk (hibernation) mode.
>
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>  arch/arm/mach-omap2/omap_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index fcd2c9e..345e18e 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -739,6 +739,9 @@ struct dev_pm_domain omap_device_pm_domain = {
>  		USE_PLATFORM_PM_SLEEP_OPS
>  		.suspend_noirq = _od_suspend_noirq,
>  		.resume_noirq = _od_resume_noirq,
> +		.freeze_noirq = _od_suspend_noirq,
> +		.thaw_noirq = _od_resume_noirq,
> +		.restore_noirq = _od_resume_noirq,
>  	}
>  };
