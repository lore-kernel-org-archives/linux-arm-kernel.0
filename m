From: syeh@vmware.com (Sinclair Yeh)
Date: Mon, 23 Jul 2018 11:02:07 -0700
Subject: [PATCH 10/10] drm/vmwgfx: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180720211509.23605-11-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
 <20180720211509.23605-11-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180723180206.GA4877@promb-2n-dhcp82.eng.vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alex,

other than adding a brief commit message to this patch,

Reviewed-by: Sinclair Yeh <syeh@vmware.com>

On Fri, Jul 20, 2018 at 10:15:09PM +0100, Alexandru Gheorghe wrote:
> Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index 466336b34fff..1e0fb3c79b50 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -720,9 +720,7 @@ void vmw_du_plane_reset(struct drm_plane *plane)
>  		return;
>  	}
>  
> -	plane->state = &vps->base;
> -	plane->state->plane = plane;
> -	plane->state->rotation = DRM_MODE_ROTATE_0;
> +	__drm_atomic_helper_plane_reset(plane, &vps->base);
>  }
>  
>  
> -- 
> 2.18.0
> 
