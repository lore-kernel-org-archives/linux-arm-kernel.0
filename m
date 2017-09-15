From: joe@perches.com (Joe Perches)
Date: Fri, 15 Sep 2017 00:28:43 -0700
Subject: [Outreachy kernel] [PATCH] gpu: drm: rockchip: Replace dev_*
 with DRM_DEV_*
In-Reply-To: <alpine.DEB.2.20.1709150857490.2287@hadrien>
References: <20170915064742.GA8367@Haneen>
 <alpine.DEB.2.20.1709150857490.2287@hadrien>
Message-ID: <1505460523.27581.5.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-09-15 at 08:58 +0200, Julia Lawall wrote:
> 
> On Fri, 15 Sep 2017, Haneen Mohammed wrote:
> 
> > This patch replace instances of dev_info/err/debug with
> > DRM_DEV_INFO/ERROR/WARN respectively inorder to use a drm-formatted
> > specific log messages. Issue corrected with the help of the following
> > Coccinelle script:
[]
> > @@ -935,7 +941,8 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
> >  		return;
> > 
> >  	if (clk_prepare_enable(dsi->pclk)) {
> > -		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
> > +		DRM_DEV_ERROR(dsi->dev,
> > +			      "%s: Failed to enable pclk\n", __func__);

The uses of "%s: " ... , __func__ with DRM_DEV_ERROR
is redundant and should be removed.

> > @@ -967,7 +974,8 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
> >  		return;
> > 
> >  	if (clk_prepare_enable(dsi->pclk)) {
> > -		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
> > +		DRM_DEV_ERROR(dsi->dev,
> > +			      "%s: Failed to enable pclk\n", __func__);

etc...
