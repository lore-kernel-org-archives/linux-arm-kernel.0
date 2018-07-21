From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Jul 2018 08:12:58 +0200
Subject: [PATCH 04/10] drm: atmel-hlcdc: Use
 __drm_atomic_helper_plane_reset instead of copying the logic
In-Reply-To: <20180720211509.23605-5-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
 <20180720211509.23605-5-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180721081258.0853da3e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandru,

On Fri, 20 Jul 2018 22:15:03 +0100
Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com> wrote:

Please add a commit message here (even if it's just repeating what the
subject says).

> Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>

With this addressed:

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 04440064b9b7..9330a076e15a 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -942,10 +942,7 @@ static void atmel_hlcdc_plane_reset(struct drm_plane *p)
>  				"Failed to allocate initial plane state\n");
>  			return;
>  		}
> -
> -		p->state = &state->base;
> -		p->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
> -		p->state->plane = p;
> +		__drm_atomic_helper_plane_reset(p, &state->base);
>  	}
>  }
>  
