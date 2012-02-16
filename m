From: khilman@ti.com (Kevin Hilman)
Date: Thu, 16 Feb 2012 10:13:03 -0800
Subject: [PATCH 2/4] ARM: OMAP2+: omap_device: Replace dev_warn by dev_dbg
 in omap_device_build_from_dt
In-Reply-To: <1329150625-8604-3-git-send-email-b-cousson@ti.com> (Benoit
 Cousson's message of "Mon, 13 Feb 2012 17:30:23 +0100")
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
 <1329150625-8604-3-git-send-email-b-cousson@ti.com>
Message-ID: <87obsyhck0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> This warning becomes a little bit too verbose with the increase of
> device nodes in some DTS files.
>
> Change it to debug only.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>


> ---
>  arch/arm/plat-omap/omap_device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 80d5e4c..125de17 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -343,7 +343,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>  
>  	oh_cnt = of_property_count_strings(node, "ti,hwmods");
>  	if (!oh_cnt || IS_ERR_VALUE(oh_cnt)) {
> -		dev_warn(&pdev->dev, "No 'hwmods' to build omap_device\n");
> +		dev_dbg(&pdev->dev, "No 'hwmods' to build omap_device\n");
>  		return -ENODEV;
>  	}
