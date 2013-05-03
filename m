From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 May 2013 17:21:37 +0200
Subject: [PATCH, RFC 04/22] staging/drm: imx: add missing dependencies
In-Reply-To: <20130503021650.GL3442@S2101-09.ap.freescale.net>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-5-git-send-email-arnd@arndb.de>
 <20130503021650.GL3442@S2101-09.ap.freescale.net>
Message-ID: <201305031721.37954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013, Shawn Guo wrote:
> On Thu, May 02, 2013 at 05:16:08PM +0200, Arnd Bergmann wrote:
> > The imx DRM driver needs a couple of extra Kconfig dependencies
> > to avoid random build failures:
> > 
> > drivers/staging/imx-drm/ipuv3-crtc.c:448:
> >  undefined reference to `ipu_idmac_put'
> >  drivers/staging/imx-drm/ipuv3-crtc.c:450: undefined reference to
> >  `ipu_dmfc_put' drivers/staging/imx-drm/ipuv3-crtc.c:452:
> >  undefined reference to `ipu_dp_put'
> >  drivers/staging/imx-drm/ipuv3-crtc.c:454: undefined reference to
> >  `ipu_di_put'
> > drivers/built-in.o: In function `ipu_probe':
> >  :(.text+0x4b4174): undefined reference to `device_reset'
> > drivers/built-in.o: In function `imx_tve_probe':
> >  drivers/staging/imx-drm/imx-tve.c:648: undefined reference to
> >  `devm_regmap_init_mmio_clk'
> > drivers/built-in.o: In function
> >  `imx_pd_connector_get_modes':
> 
> >  drivers/staging/imx-drm/parallel-display.c:78: undefined
> >  reference to `of_get_drm_display_mode'
> 
> There is a patch [1] from Marek fixing this one.
> 
> Shawn
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/233449
> 

That patch only addresses one of the four missing dependencies.
I originally had four separate patches, but did not want to
bother everyone with those so I combined them into one.

	Arnd
