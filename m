From: eric@anholt.net (Eric Anholt)
Date: Fri, 08 Sep 2017 10:49:41 -0700
Subject: [PATCH] drm/tve200: Clean up panel bridging
In-Reply-To: <20170907211933.8308-1-linus.walleij@linaro.org>
References: <20170907211933.8308-1-linus.walleij@linaro.org>
Message-ID: <87bmmlnkqy.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This makes use of the drm_simple_display_pipe_attach_bridge()
> call and removes the two calls removing the bridge, which were
> erroneous: they unregister the bridge which is not what
> we want, we just want to unreference it and that is already
> handled by the core.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/tve200/tve200_display.c |  3 ---
>  drivers/gpu/drm/tve200/tve200_drv.c     | 30 +++++++++++++-----------------
>  2 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
> index cfdffc15a2ce..fd193377c3c0 100644
> --- a/drivers/gpu/drm/tve200/tve200_display.c
> +++ b/drivers/gpu/drm/tve200/tve200_display.c
> @@ -332,8 +332,5 @@ int tve200_display_init(struct drm_device *drm)
>  	if (ret)
>  		return ret;
>  
> -	/* We need the encoder to attach the bridge */
> -	priv->encoder = &priv->pipe.encoder;

Also drop the encoder field from priv?

Other than that,

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170908/01faa2af/attachment.sig>
