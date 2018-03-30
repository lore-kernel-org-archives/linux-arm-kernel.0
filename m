From: eric@anholt.net (Eric Anholt)
Date: Fri, 30 Mar 2018 13:37:36 -0700
Subject: [PATCH v4 1/5] drm/blend: Add a generic alpha property
In-Reply-To: <402e596049beb3429faf5981682d902c70325274.1520974361.git-series.maxime.ripard@bootlin.com>
References: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
 <402e596049beb3429faf5981682d902c70325274.1520974361.git-series.maxime.ripard@bootlin.com>
Message-ID: <87vadd5mgf.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@bootlin.com> writes:

> Some drivers duplicate the logic to create a property to store a per-plane
> alpha.
>
> This is especially useful if we ever want to support extra protocols for
> Wayland like:
> https://lists.freedesktop.org/archives/wayland-devel/2017-August/034741.html
>
> Let's create a helper in order to move that to the core.

> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 5a81e1b4c076..05eda2d57c77 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -88,6 +88,12 @@
>   * On top of this basic transformation additional properties can be exposed by
>   * the driver:
>   *
> + * alpha:
> + * 	Alpha is setup with drm_plane_create_alpha_property(). It controls the

s/setup/set up/

> + * 	plane-wide opacity, from transparent (0) to opaque (0xffff). It can be
> + * 	combined with pixel alpha.
> + * 	The alpha value is represented as premultiplied alpha.

I don't think this premultiplied comment makes any sense.  What are you
saying it's premultiplied with?  Maybe you mean that the output pixels
will have both their color and alpha channels multiplied by this alpha?
I'd just drop it.

Reviewed-by: Eric Anholt <eric@anholt.net>

We should probably do this property for vc4 at some point, too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180330/249a4627/attachment.sig>
