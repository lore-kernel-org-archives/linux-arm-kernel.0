From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 20 Dec 2016 20:04:52 +0800
Subject: [PATCH] drm: zte: add overlay plane support
In-Reply-To: <20161208155755.GY31595@intel.com>
References: <1481166761-5100-1-git-send-email-shawnguo@kernel.org>
 <20161208155755.GY31595@intel.com>
Message-ID: <20161220120451.GC8787@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ville,

On Thu, Dec 08, 2016 at 05:57:55PM +0200, Ville Syrj?l? wrote:
> On Thu, Dec 08, 2016 at 11:12:41AM +0800, Shawn Guo wrote:
> <snip>
> > +static void zx_vl_plane_atomic_update(struct drm_plane *plane,
> > +				      struct drm_plane_state *old_state)
> > +{
> > +	struct zx_plane *zplane = to_zx_plane(plane);
> > +	struct drm_framebuffer *fb = plane->state->fb;
> > +	struct drm_gem_cma_object *cma_obj;
> > +	void __iomem *layer = zplane->layer;
> > +	void __iomem *hbsc = zplane->hbsc;
> > +	void __iomem *paddr_reg;
> > +	dma_addr_t paddr;
> > +	u32 src_x, src_y, src_w, src_h;
> > +	u32 dst_x, dst_y, dst_w, dst_h;
> > +	uint32_t format;
> > +	u32 fmt;
> > +	int num_planes;
> > +	int i;
> > +
> > +	if (!fb)
> > +		return;
> > +
> > +	format = fb->pixel_format;
> > +
> > +	src_x = plane->state->src_x >> 16;
> > +	src_y = plane->state->src_y >> 16;
> > +	src_w = plane->state->src_w >> 16;
> > +	src_h = plane->state->src_h >> 16;
> > +
> > +	dst_x = plane->state->crtc_x;
> > +	dst_y = plane->state->crtc_y;
> > +	dst_w = plane->state->crtc_w;
> > +	dst_h = plane->state->crtc_h;
> 
> This shouls use the clipped coordiantes.

Thanks for spotting this.  I will fix it in v2.

Shawn
