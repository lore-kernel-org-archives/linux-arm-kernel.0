From: khilman@ti.com (Kevin Hilman)
Date: Thu, 24 Mar 2011 10:18:49 -0700
Subject: [PATCH 2/6] arm: mach-omap2: smartreflex: fix sr_late_init()
	error path in probe
In-Reply-To: <1300984535-10530-2-git-send-email-aaro.koskinen@nokia.com> (Aaro
	Koskinen's message of "Thu, 24 Mar 2011 18:35:31 +0200")
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
	<1300984535-10530-2-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <87fwqczbba.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> sr_late_init() will take care of freeing the resources.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks,

As I've already got some other SR related stuff queued up for 2.6.39,
I'll queue patches 2-6 for the 2.6.39-rc fixes cycle.

Tony can take patch 1 as he see's fit.

Also, I renamed the subject/shortlog to use 'OMAP2+: smartreflex: ..."
instead of 'arm: mach-omap2'.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 8f674c9..6dfc8db 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -883,7 +883,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  		ret = sr_late_init(sr_info);
>  		if (ret) {
>  			pr_warning("%s: Error in SR late init\n", __func__);
> -			goto err_release_region;
> +			return ret;
>  		}
>  	}
