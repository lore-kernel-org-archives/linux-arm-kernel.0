From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 1 Mar 2018 10:56:28 +0100
Subject: [PATCH 1/2] drm/sun4i: increase lvds dclk max divisor
In-Reply-To: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180301095628.7wmzahyxwlffptmx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 06:53:51PM +0100, Giulio Benetti wrote:
> At the moment both min and max dclk div are set to 7.
> This doesn't allow to have lower frequencies.
> 
> Increase dclk_max_div to 18 to achieve 30Mhz.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 029d2ce..bb35f41 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -278,7 +278,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>  	u32 reg, val = 0;
>  
>  	tcon->dclk_min_div = 7;
> -	tcon->dclk_max_div = 7;
> +	tcon->dclk_max_div = 18;

This needs much more justification.

What panel did you test it on? Why aren't we able to reach 30MHz
already? Why do you care about 30MHz and not any other frequency?

https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/drivers/video/sunxi/disp/disp_clk.c#L686

Why Allwinner is always using 7, just like U-Boot is, and we should
use something different?

Why 18 would be a better choice?

All that should be in your commit log.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/0ed1e6ec/attachment.sig>
