From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Fri, 11 Feb 2011 09:57:13 +0200
Subject: [PATCH] ARM: SAMSUNG: Removing dependency on CONFIG_PM_DEBUG for
	clock debugging
In-Reply-To: <1297530374-32635-1-git-send-email-amit.kachhap@linaro.org>
References: <1297530374-32635-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <AANLkTinjhPP9NxLsOMovETAZLzFO70zmVWtPQ+E4PZj9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 7:06 PM, Amit Daniel Kachhap
<amit.kachhap@linaro.org> wrote:
> Enabling the macro CONFIG_PM_DEBUG is causing compilation error as all PM components
> are included which is not in mainline for samsung V310 platform, therefore, this patch
> removes the dependency on macro CONFIG_PM_DEBUG for clock debugging through debugfs
> interface.

What is the exact error? Might be helpful to have it in the patch description.

Presumably, this is a temporary patch until PM components
(suspend/resume hooks?) are mainlined and then we can put all this
back under PM_DEBUG? In that case, it might be a good idea to mark it
as such.

Regards,
Amit

> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> ---
> ?arch/arm/plat-samsung/clock.c ? ? ? ? ? ? ?| ? ?4 ++--
> ?arch/arm/plat-samsung/include/plat/clock.h | ? ?2 +-
> ?2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
> index 7728928..aca5a25 100644
> --- a/arch/arm/plat-samsung/clock.c
> +++ b/arch/arm/plat-samsung/clock.c
> @@ -450,7 +450,7 @@ int __init s3c24xx_register_baseclocks(unsigned long xtal)
> ? ? ? ?return 0;
> ?}
>
> -#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> +#if defined(CONFIG_DEBUG_FS)
> ?/* debugfs support to trace clock tree hierarchy and attributes */
>
> ?static struct dentry *clk_debugfs_root;
> @@ -538,4 +538,4 @@ err_out:
> ?}
> ?late_initcall(clk_debugfs_init);
>
> -#endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
> +#endif /* defined(CONFIG_DEBUG_FS) */
> diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
> index 9a82b88..f6180ab 100644
> --- a/arch/arm/plat-samsung/include/plat/clock.h
> +++ b/arch/arm/plat-samsung/include/plat/clock.h
> @@ -47,7 +47,7 @@ struct clk {
>
> ? ? ? ?struct clk_ops ? ? ? ? ?*ops;
> ? ? ? ?int ? ? ? ? ? ? ? ? (*enable)(struct clk *, int enable);
> -#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> +#if defined(CONFIG_DEBUG_FS)
> ? ? ? ?struct dentry ? ? ? ? ? *dent; ?/* For visible tree hierarchy */
> ?#endif
> ?};
> --
> 1.7.1
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
