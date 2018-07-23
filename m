From: drawat@vmware.com (Deepak Singh Rawat)
Date: Mon, 23 Jul 2018 17:16:31 +0000
Subject: [PATCH 10/10] drm/vmwgfx: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180720211509.23605-11-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
 <20180720211509.23605-11-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <BYAPR05MB4181BDF5EF98126FDDCD3CB6BA560@BYAPR05MB4181.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandru,

Thanks for the patch, for the vmwgfx part:

Reviewed-by: Deepak Rawat <drawat@vmware.com>

> 
> Signed-off-by: Alexandru Gheorghe <alexandru-
> cosmin.gheorghe at arm.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
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
