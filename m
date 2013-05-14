From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 May 2013 11:08:20 -0700
Subject: [PATCH] ARM : omap : remove __init for _enable_preprogram
In-Reply-To: <1368547621-8570-1-git-send-email-jp.francois@cynove.com> (jp
 francois's message of "Tue, 14 May 2013 18:07:01 +0200")
References: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
Message-ID: <8738tpxwmj.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jp.francois at cynove.com writes:

> _enable_preprogram is marked as __init, but is called from _enable which is not.
> This results in oops once init is freed.
> Fix this by removing the __init marker.
>
> Signed-off-by: Jean-Philippe Fran?ois <jp.francois@cynove.com>

Acked-by: Kevin Hilman <khilman@linaro.org>

Tony, this should probably be queued for v3.10-rc, and tagged for stable.

Kevin

> Index: b/arch/arm/mach-omap2/omap_hwmod.c
> ===================================================================
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2066,7 +2066,7 @@
>   * do so is present in the hwmod data, then call it and pass along the
>   * return value; otherwise, return 0.
>   */
> -static int __init _enable_preprogram(struct omap_hwmod *oh)
> +static int _enable_preprogram(struct omap_hwmod *oh)
>  {
>  	if (!oh->class->enable_preprogram)
>  		return 0;
