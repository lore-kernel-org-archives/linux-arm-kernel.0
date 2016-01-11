From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 11 Jan 2016 19:56:24 +0100
Subject: [PATCH RFC 2/2] drm: sunxi: Add a basic DRM driver for
 Allwinner DE2
In-Reply-To: <20160105203817.GZ19062@n2100.arm.linux.org.uk>
References: <cover.1452021349.git.moinejf@free.fr>
 <58463fd5b674c7eedec4ae05567ee56770a12996.1452021349.git.moinejf@free.fr>
 <20160105203817.GZ19062@n2100.arm.linux.org.uk>
Message-ID: <20160111195624.ef9e332883b9369f0a8b586c@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jan 2016 20:38:17 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Some comments from an ARM architecture point of view.  I haven't
> reviewed it from a DRM point of view yet.

Anyway, thanks for your explanations and remarks.

> > +static void de2_crtc_enable(struct drm_crtc *crtc)
> > +{
	...
> > +	clk_set_rate(lcd->clk, mode->clock * 1000);
> 
> What if the clock can't support the rate?

The function enabling the CRTC has no return code, so the screen would
be blurred. But this would not occur: the video PLL is in the range
30..600MHz.

> > +static int de2_hdmi_connector_mode_valid(struct drm_connector *connector,
> > +					struct drm_display_mode *mode)
> > +{
> > +	if (!drm_match_cea_mode(mode))
> > +		return MODE_NOMODE;
> 
> Maybe detect modes with a zero clock here instead?

We have no documentation about the HDMI hardware and only the CEA modes
are handled in Allwinner's driver.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
