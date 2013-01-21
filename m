From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 Jan 2013 13:17:36 +0100
Subject: [PATCH 2/8] pinctrl: add SDHI and MMCIF pin groups to sh7372
In-Reply-To: <1358356097-26180-3-git-send-email-g.liakhovetski@gmx.de>
References: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
 <1358356097-26180-3-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <2003703.ytJOxU5lq9@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

Thanks for the patch.

On Wednesday 16 January 2013 18:08:11 Guennadi Liakhovetski wrote:
> Add pin groups for all three SDHI interfaces and two alternative pin
> groups for the MMCIF interface on the sh7372 SoC.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/pinctrl/sh-pfc/pfc-sh7372.c |  205 ++++++++++++++++++++++++++++++++
>  1 files changed, 205 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
> b/drivers/pinctrl/sh-pfc/pfc-sh7372.c index 847e0cd..78444a0 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c

[snip]

> @@ -1644,6 +1844,11 @@ struct sh_pfc_soc_info sh7372_pinmux_info = {
> 
>  	.pins = pinmux_pins,
>  	.nr_pins = ARRAY_SIZE(pinmux_pins),
> +	.groups		= pinmux_groups,
> +	.nr_groups	= ARRAY_SIZE(pinmux_groups),
> +	.functions	= pinmux_functions,
> +	.nr_functions	= ARRAY_SIZE(pinmux_functions),
> +

Just a little bit of nitpicking here. I don't have a strong preference on 
whether the = signs should be aligned. Both options were used in the PFC code, 
so I've tried to keep whatever was there. It might be better to do so here as 
well.

>  	.func_gpios = pinmux_func_gpios,
>  	.nr_func_gpios = ARRAY_SIZE(pinmux_func_gpios),
-- 
Regards,

Laurent Pinchart
