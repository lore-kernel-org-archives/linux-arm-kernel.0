From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 6 Nov 2018 16:57:12 +0100
Subject: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if NULL
In-Reply-To: <f140c083f59eabf6ea323d15d655473e8a77d813.camel@aosc.io>
References: <20181004195605.txvbkshvxklyzxyb@flea>
 <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
 <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
 <20181008092111.qcufr4o7cy3nnj4b@flea>
 <f140c083f59eabf6ea323d15d655473e8a77d813.camel@aosc.io>
Message-ID: <20181106155712.4lcxw7yts7jixnkl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 09:23:08PM +0800, Icenowy Zheng wrote:
> ? 2018-10-08?? 11:21 +0200?Maxime Ripard???
> > On Fri, Oct 05, 2018 at 11:59:51PM +0200, Giulio Benetti wrote:
> > > If tcon->panel pointer is NULL, trying to dereference from it
> > > (i.e. tcon->panel->connector) will cause a null pointer
> > > dereference.
> > > 
> > > Add tcon->panel null pointer check before calling
> > > sun4i_tcon0_mode_set_dithering().
> > > 
> > > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
> > >                       RGB565/RGB666 LCD panels")
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > 
> > Applied both, thanks!
> 
> Please bring them to 4.20.
> 
> Currently in 4.20-rc1, bridge support of sun4i-drm is broken because of
> this problem.

I've merged them in drm-misc-fixes, thanks!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181106/c369b5f1/attachment.sig>
