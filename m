From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 22 Jan 2017 14:44:55 +0800
Subject: [PATCH v2 08/26] drm/rockchip: dw-mipi-dsi: include bad value in
 error message
In-Reply-To: <20170121163128.22240-9-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-9-john@metanate.com>
Message-ID: <588454E7.80200@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John

Reviewed-by: Chris Zhong <zyw@rock-chips.com>


On 01/22/2017 12:31 AM, John Keeping wrote:
> As an aid to debugging.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Unchanged in v2
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 2e6ad4591ebf..92dbc3e56603 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -644,7 +644,8 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>   		ret = dw_mipi_dsi_dcs_long_write(dsi, msg);
>   		break;
>   	default:
> -		dev_err(dsi->dev, "unsupported message type\n");
> +		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
> +			msg->type);
>   		ret = -EINVAL;
>   	}
>   
