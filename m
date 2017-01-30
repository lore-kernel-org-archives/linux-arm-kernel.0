From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 30 Jan 2017 13:02:47 -0500
Subject: [PATCH v3 07/24] drm/rockchip: dw-mipi-dsi: include bad value in
 error message
In-Reply-To: <20170129132444.25251-8-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-8-john@metanate.com>
Message-ID: <20170130180247.GH20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 01:24:27PM +0000, John Keeping wrote:
> As an aid to debugging.

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> 
> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> ---
> v3:
> - Add Chris' Reviewed-by
> Unchanged in v2
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 2e6ad4591ebf..92dbc3e56603 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -644,7 +644,8 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>  		ret = dw_mipi_dsi_dcs_long_write(dsi, msg);
>  		break;
>  	default:
> -		dev_err(dsi->dev, "unsupported message type\n");
> +		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
> +			msg->type);
>  		ret = -EINVAL;
>  	}
>  
> -- 
> 2.11.0.197.gb556de5.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
