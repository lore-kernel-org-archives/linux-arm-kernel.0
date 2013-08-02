From: nm@ti.com (Nishanth Menon)
Date: Fri, 2 Aug 2013 07:54:57 -0500
Subject: [PATCH 1/2] ARM: OMAP: dss-common: fix Panda's DVI DDC channel
In-Reply-To: <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
 <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <51FBAC21.2040609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 04:06 AM, Tomi Valkeinen wrote:
> Panda's DVI connector's DDC pins are connected to OMAP's third i2c bus.
> With non-DT, the bus number was 3, and that is what is used in the
> dss-common.c which contains the platform data for Panda's DVI.
>
> However, with DT, the bus number is 2. As we now only have DT boot for
> Panda, we have to change the bus number to make DVI EDID read
> operational.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/dss-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
> index 393aeef..043e570 100644
> --- a/arch/arm/mach-omap2/dss-common.c
> +++ b/arch/arm/mach-omap2/dss-common.c
> @@ -42,7 +42,7 @@
>
>   /* Using generic display panel */
>   static struct tfp410_platform_data omap4_dvi_panel = {
> -	.i2c_bus_num		= 3,
> +	.i2c_bus_num		= 2,
>   	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
>   };
>
>
completely dumb question :) :
why cant we have dts support for this instead of having to renumber 
every time?

Example: if -EPROBEDEFER is incurred due to some unexpected dependency, 
we'd have to redo the numbering in the kernel yet again.

-- 
Regards,
Nishanth Menon
