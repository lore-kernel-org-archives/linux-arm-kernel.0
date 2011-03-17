From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Mar 2011 11:22:00 +0530
Subject: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init() return
	value
In-Reply-To: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
References: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <324bffcaf53be55bd6f392af3f86fa10@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Aaro Koskinen
> Sent: Wednesday, March 16, 2011 10:46 PM
> To: linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; tony at atomide.com
> Cc: Aaro Koskinen
> Subject: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init()
> return value
>
> Fix the return value for the successful case.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/devices.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
> omap2/devices.c
> index 0d2d6a9..d478f53 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -65,7 +65,7 @@ static int __init omap3_l3_init(void)
>
>  	WARN(IS_ERR(od), "could not build omap_device for %s\n",
> oh_name);
>
> -	return PTR_ERR(od);
> +	return IS_ERR(od) ? PTR_ERR(od) : 0;
>  }
>  postcore_initcall(omap3_l3_init);
>
Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
