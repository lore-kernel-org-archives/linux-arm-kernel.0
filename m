From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 14 Nov 2018 15:49:30 +0100
Subject: [PATCH -next] drm/sun4i: hdmi: Use PTR_ERR_OR_ZERO in
 sun4i_tmds_create()
In-Reply-To: <1541558063-100341-1-git-send-email-yuehaibing@huawei.com>
References: <1541558063-100341-1-git-send-email-yuehaibing@huawei.com>
Message-ID: <20181114144930.j26xlro2cke47xza@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Nov 07, 2018 at 02:34:23AM +0000, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> index fb985ba..3d5ee6f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> @@ -232,8 +232,5 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
>  	tmds->div_offset = hdmi->variant->tmds_clk_div_offset;
>  
>  	hdmi->tmds_clk = devm_clk_register(hdmi->dev, &tmds->hw);
> -	if (IS_ERR(hdmi->tmds_clk))
> -		return PTR_ERR(hdmi->tmds_clk);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(hdmi->tmds_clk);

While this is technically correct (and I appreciate that this is also
a matter of taste), I find the former syntax to be clearer and easier
to extend if needed.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/9b332000/attachment.sig>
