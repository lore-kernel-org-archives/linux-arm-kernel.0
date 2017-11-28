From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 21:31:57 +0100
Subject: [PATCH 10/17] drm/sun4i: Add scaler configuration to DE2 mixers
In-Reply-To: <20171127205750.19277-11-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-11-jernej.skrabec@siol.net>
Message-ID: <20171128203157.id6mflespftuavbq@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 27, 2017 at 09:57:43PM +0100, Jernej Skrabec wrote:
> No all SoCs support scaling on all channels. For example, V3s support
> scaling only on VI channels. Because of that, add additional
> configuration bitmask which tells which channel support scaler.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 1 +
>  drivers/gpu/drm/sun4i/sun8i_mixer.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index dc97351be973..291dd8806444 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -576,6 +576,7 @@ static int sun8i_mixer_remove(struct platform_device *pdev)
>  static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
>  	.vi_num = 2,
>  	.ui_num = 1,
> +	.scaler_mask = 0x3,
>  };
>  
>  static const struct of_device_id sun8i_mixer_of_table[] = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> index 572ef184a21a..ad5aef5846ae 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -139,6 +139,7 @@
>  struct sun8i_mixer_cfg {
>  	int		vi_num;
>  	int		ui_num;
> +	int		scaler_mask;

Can you add a comment there to explain what the scaler_mask is ?
(ideally in kerneldoc)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/273e37ec/attachment.sig>
