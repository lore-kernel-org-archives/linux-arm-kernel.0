From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 05 Nov 2018 21:23:08 +0800
Subject: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if NULL
In-Reply-To: <20181008092111.qcufr4o7cy3nnj4b@flea>
References: <20181004195605.txvbkshvxklyzxyb@flea>
 <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
 <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
 <20181008092111.qcufr4o7cy3nnj4b@flea>
Message-ID: <f140c083f59eabf6ea323d15d655473e8a77d813.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018-10-08?? 11:21 +0200?Maxime Ripard???
> On Fri, Oct 05, 2018 at 11:59:51PM +0200, Giulio Benetti wrote:
> > If tcon->panel pointer is NULL, trying to dereference from it
> > (i.e. tcon->panel->connector) will cause a null pointer
> > dereference.
> > 
> > Add tcon->panel null pointer check before calling
> > sun4i_tcon0_mode_set_dithering().
> > 
> > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
> >                       RGB565/RGB666 LCD panels")
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Applied both, thanks!

Please bring them to 4.20.

Currently in 4.20-rc1, bridge support of sun4i-drm is broken because of
this problem.

> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
