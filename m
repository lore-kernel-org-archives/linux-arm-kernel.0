From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Sep 2017 12:20:06 +0200
Subject: [PATCH v3 04/14] drm/sun4i: tcon: Add support for demuxing TCON
 output on A31
In-Reply-To: <20170929082306.16193-5-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-5-wens@csie.org>
Message-ID: <20170929102006.2wz7wrkpplxwynoh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 08:22:56AM +0000, Chen-Yu Tsai wrote:
> On systems with 2 TCONs such as the A31, it is possible to demux the
> output of the TCONs to one encoder.
> 
> Add support for this for the A31.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 7bf51abaee97..c949309d4285 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -112,6 +112,21 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
>  }
>  EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
>  
> +static struct sun4i_tcon *sun4i_get_first_tcon(struct drm_device *drm)

Would that make sense to make it a bit more generic, and pass the id
to look for as an argument?

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/671f9852/attachment.sig>
