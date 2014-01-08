From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jan 2014 21:25:12 +0000
Subject: [PATCH RFC 24/46] imx-drm: provide common connector mode
 validation function
In-Reply-To: <20140107063803.GB12346@S2101-09.ap.freescale.net>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypnw-0007F7-EB@rmk-PC.arm.linux.org.uk>
 <20140107063803.GB12346@S2101-09.ap.freescale.net>
Message-ID: <20140108212512.GQ27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 02:38:05PM +0800, Shawn Guo wrote:
> On Thu, Jan 02, 2014 at 09:27:48PM +0000, Russell King wrote:
> > diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
> > index 5649f180dc44..4eb594ce9cff 100644
> > --- a/drivers/staging/imx-drm/imx-drm.h
> > +++ b/drivers/staging/imx-drm/imx-drm.h
> > @@ -68,4 +68,7 @@ int imx_drm_encoder_get_mux_id(struct drm_encoder *encoder);
> >  int imx_drm_encoder_add_possible_crtcs(struct imx_drm_encoder *imx_drm_encoder,
> >  		struct device_node *np);
> >  
> > +int imx_drm_connector_mode_valid(struct drm_connector *connector,
> > +	struct drm_display_mode *mode);
> > +
> >  #endif /* _IMX_DRM_H_ */
> 
>   CC      drivers/staging/imx-drm/ipu-v3/ipu-dc.o
>   LD      net/ethernet/built-in.o
> In file included from drivers/staging/imx-drm/ipu-v3/ipu-dc.c:23:0:
> drivers/staging/imx-drm/ipu-v3/../imx-drm.h:56:9: warning: ?struct drm_display_mode? declared inside parameter list [enabled by default]
> drivers/staging/imx-drm/ipu-v3/../imx-drm.h:56:9: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Thanks, fixed.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
