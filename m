From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 09 Jan 2018 14:56:21 +0200
Subject: [PATCH 03/11] drm/bridge/synopsys: dw-hdmi: Enable workaround for
 v1.32a
In-Reply-To: <20171230210203.24115-4-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <20171230210203.24115-4-jernej.skrabec@siol.net>
Message-ID: <3367423.0HCaRuLuz8@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

Thank you for the patch.

On Saturday, 30 December 2017 23:01:55 EET Jernej Skrabec wrote:
> Allwinner SoCs have dw hdmi controller v1.32a which exhibits same
> magenta line issue as i.MX6Q and i.MX6DL. Enable workaround for it.
> 
> Tests show that one iteration is enough.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

This does not break R-Car DU, so

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> a38db40ce990..7ca14d7325b5 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1634,9 +1634,10 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi
> *hdmi) * then write one of the FC registers several times.
>  	 *
>  	 * The number of iterations matters and depends on the HDMI TX revision
> -	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
> -	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
> -	 * 4 and 1 iterations respectively.
> +	 * (and possibly on the platform). So far i.MX6Q (v1.30a), i.MX6DL
> +	 * (v1.31a) and multiple Allwinner SoCs (v1.32a) have been identified
> +	 * as needing the workaround, with 4 iterations for v1.30a and 1
> +	 * iteration for others.
>  	 */
> 
>  	switch (hdmi->version) {
> @@ -1644,6 +1645,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi
> *hdmi) count = 4;
>  		break;
>  	case 0x131a:
> +	case 0x132a:
>  		count = 1;
>  		break;
>  	default:

-- 
Regards,

Laurent Pinchart
