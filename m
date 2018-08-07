From: syeh@vmware.com (Sinclair Yeh)
Date: Tue, 7 Aug 2018 06:25:58 -0700
Subject: [PATCH v3 10/10] drm/vmwgfx: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180807080327.GA32008@e114479-lin.cambridge.arm.com>
References: <20180804161530.12275-1-alexandru-cosmin.gheorghe@arm.com>
 <20180804161530.12275-11-alexandru-cosmin.gheorghe@arm.com>
 <20180806165752.GD17089@vmware.com>
 <20180807080327.GA32008@e114479-lin.cambridge.arm.com>
Message-ID: <20180807132557.GA1160@vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 09:03:27AM +0100, Alexandru-Cosmin Gheorghe wrote:
> Hi Sinclair,
> 
> Is it ok if I merge this patch through drm-misc-next ?

Sure. Thanks for handling this.

Sinclair

> Thank you,
> Alex Gheorghe
> 
> On Mon, Aug 06, 2018 at 09:57:53AM -0700, Sinclair Yeh wrote:
> > Acked-by: Sinclair Yeh <syeh@vmware.com>
> > 
> > On Sat, Aug 04, 2018 at 05:15:30PM +0100, Alexandru Gheorghe wrote:
> > > A new helper function(__drm_atomic_helper_plane_reset) has been added
> > > for linking a plane with its state and resetting the core
> > > properties(alpha, rotation, etc.) to their default values.
> > > Use that instead of duplicating the logic.
> > > 
> > > Reviewed-by: Sinclair Yeh <syeh@vmware.com>
> > > Reviewed-by: Deepak Rawat <drawat@vmware.com>
> > > Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> > > ---
> > >  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> > > index 4a0f0f41afa1..61824e360619 100644
> > > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> > > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> > > @@ -720,9 +720,7 @@ void vmw_du_plane_reset(struct drm_plane *plane)
> > >  		return;
> > >  	}
> > >  
> > > -	plane->state = &vps->base;
> > > -	plane->state->plane = plane;
> > > -	plane->state->rotation = DRM_MODE_ROTATE_0;
> > > +	__drm_atomic_helper_plane_reset(plane, &vps->base);
> > >  }
> > >  
> > >  
> > > -- 
> > > 2.18.0
> > > 
> 
> -- 
> Cheers,
> Alex G
