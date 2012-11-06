From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 6 Nov 2012 12:37:35 +0100 (CET)
Subject: [PATCH 1/2] ARM: i.MX27: Add platform support for IRAM.
In-Reply-To: <1352131185-12079-1-git-send-email-javier.martin@vista-silicon.com>
References: <1352131185-12079-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <Pine.LNX.4.64.1211061232510.6451@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier

On Mon, 5 Nov 2012, Javier Martin wrote:

> Add support for IRAM to i.MX27 non-DT platforms using
> iram_init() function.

I'm not sure this belongs in a camera driver. Can IRAM not be used for 
anything else? I'll check the i.MX27 datasheet when I'm back home after 
the conference, so far this seems a bit odd.

Thanks
Guennadi

> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  arch/arm/mach-imx/mm-imx27.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
> index e7e24af..fd2416d 100644
> --- a/arch/arm/mach-imx/mm-imx27.c
> +++ b/arch/arm/mach-imx/mm-imx27.c
> @@ -27,6 +27,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/mach/map.h>
>  #include <mach/iomux-v1.h>
> +#include <mach/iram.h>
>  
>  /* MX27 memory map definition */
>  static struct map_desc imx27_io_desc[] __initdata = {
> @@ -94,4 +95,6 @@ void __init imx27_soc_init(void)
>  	/* imx27 has the imx21 type audmux */
>  	platform_device_register_simple("imx21-audmux", 0, imx27_audmux_res,
>  					ARRAY_SIZE(imx27_audmux_res));
> +	/* imx27 has an iram of 46080 bytes size */
> +	iram_init(MX27_IRAM_BASE_ADDR, 46080);
>  }
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
