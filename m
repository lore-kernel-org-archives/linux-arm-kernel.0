From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 15:36:03 +0200
Subject: [linux-sunxi] Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
In-Reply-To: <5673885.I9ZBC4zXdg@jernej-laptop>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <2406320.TaIT7vHipu@jernej-laptop>
 <20180711093016.bcnsnogbj26azoo7@flea>
 <5673885.I9ZBC4zXdg@jernej-laptop>
Message-ID: <20180711133603.xfc5fxkocdl4okca@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 11:34:58AM +0200, Jernej ?krabec wrote:
> Dne sreda, 11. julij 2018 ob 11:30:16 CEST je Maxime Ripard napisal(a):
> > On Wed, Jul 11, 2018 at 10:41:54AM +0200, Jernej ?krabec wrote:
> > > Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard napisal(a):
> > > > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > > > > This series fixes several issues found in R40 HDMI patch series after
> > > > > it was applied. Conversation can be found here:
> > > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011
> > > > > .htm
> > > > > l
> > > > > 
> > > > > Patches are based on latest linux-next (next-20180710) and are ordered
> > > > > in such way that they don't break R40 HDMI at any time. Because of
> > > > > that
> > > > > I suggest that whole series goes through drm-misc to preserve that
> > > > > order.
> > > > > 
> > > > > I also tested those patches on H3 to make sure it doesn't break other
> > > > > platforms. However, it would be nice to test for regressions also on
> > > > > older SoCs (with DE1).
> > > > > 
> > > > > Best regards,
> > > > > Jernej
> > > > 
> > > > Applied all patches but the patch 10, thanks!
> > > > Maxime
> > > 
> > > Ok, I'll send patch 10 separately. However,  patch 4 needs a fix according
> > > to test build robot:
> > > 
> > > if (IS_ERR_VALUE(index))
> > > should be:
> > > if (index < 0)
> > 
> > Yeah, sorry, I forgot to say it, but I fixed it locally (and the
> > return below as well).
> > 
> > > Additionally, due to Arnds patch merged (drm/sun4i: fix build failure with
> > > CONFIG_DRM_SUN8I_MIXER=m), sun4i_tcon.c needs additional handling if
> > > TCON_TOP driver is not build.
> > 
> > I'll drop it then, I haven't pushed it yet.
> 
> Which one? This series or patch from Arnd?

Arnd's

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/a48f7c99/attachment-0001.sig>
