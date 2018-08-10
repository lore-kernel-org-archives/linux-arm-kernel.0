From: seanpaul@chromium.org (Sean Paul)
Date: Fri, 10 Aug 2018 12:11:05 -0400
Subject: [PATCH v2 4/7] drm/i2c: tda998x: convert to bridge driver
In-Reply-To: <20180808221547.GN30658@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <E1fkBFV-00048s-O2@rmk-PC.armlinux.org.uk>
 <20180808190930.GQ20303@art_vandelay>
 <20180808221547.GN30658@n2100.armlinux.org.uk>
Message-ID: <20180810161105.GT20303@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 11:15:47PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 08, 2018 at 03:09:30PM -0400, Sean Paul wrote:
> > > -static const struct drm_encoder_helper_funcs tda998x_encoder_helper_funcs = {
> > > -	.dpms = tda998x_encoder_dpms,
> > > -	.prepare = tda998x_encoder_prepare,
> > > -	.commit = tda998x_encoder_commit,
> > > -	.mode_set = tda998x_encoder_mode_set,
> > > -};
> > 
> > Now that encoder is a stub, it should really be removed from here. The encoder
> > should be instantiated elsewhere and attach the bridge to itself. There are a
> > bunch of examples of this in bridge/
> 
> That's not possible at present - this driver has to remain compatible
> with Armada and TI LCDC, both of which expect this driver to create
> the encoder.

Hmm, yeah, I just read that thread. I suppose once bridges play nice with
components the encoder can migrate into the drivers?

> 
> In any case, bridges are buggy with unbinding/rebinding as I've pointed
> out several times in the past, but TDA998x used with Armada and TI LCDC
> as it currently stands are not.  So, to do this as a full conversion to
> bridge and pushing the encoders into the DRM drivers results in a
> regression for these two DRM drivers.  I'm not willing to accept such
> a regression, sorry.
> 
> Thanks for the other cleanup suggestions, they can be done with a
> later patch (these changes have already been been merged.)

I still think you should get review from a bridge maintainer before it goes to
drm-next.

Sean

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
> According to speedtest.net: 13Mbps down 490kbps up

-- 
Sean Paul, Software Engineer, Google / Chromium OS
