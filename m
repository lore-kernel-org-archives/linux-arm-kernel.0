From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 Jan 2013 13:09:40 +0100
Subject: [PATCH v2 1/8] pinctrl: add SDHI and MMCIF pin groups to r8a7740
In-Reply-To: <Pine.LNX.4.64.1301171103020.30897@axis700.grange>
References: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
 <1358356097-26180-2-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1301171103020.30897@axis700.grange>
Message-ID: <1415012.Vse2oGtvn2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

Thanks for the patch.

On Thursday 17 January 2013 11:04:26 Guennadi Liakhovetski wrote:
> Add pin groups for all three SDHI interfaces and two alternative pin
> groups for the MMCIF interface on the r8a7740 SoC.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v2: add SDHI2 pins
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  248 +++++++++++++++++++++++++++++++
>  1 files changed, 248 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index d0b7165..57d9e25 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> @@ -1870,6 +1870,188 @@ static const unsigned int lcd1_sys_mux[] = {

[snip]

> +static const unsigned int mmc0_ctrl_0_pins[] = {
> +	/* CMD, CLK */
> +	66, 67,

Shouldn't this be 67, 66 ?

> +};
> +static const unsigned int mmc0_ctrl_0_mux[] = {
> +	MMC0_CMD_PORT67_MARK, MMC0_CLK_PORT66_MARK,
> +};

-- 
Regards,

Laurent Pinchart
