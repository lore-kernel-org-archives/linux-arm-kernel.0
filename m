From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 3 Aug 2011 07:39:27 +0000
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110802164005.GI25884@opensource.wolfsonmicro.com>
References: <65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
	<20110802164005.GI25884@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F4F43@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: Wednesday, August 03, 2011 12:40 AM
> To: Takashi Iwai
> Cc: Dong Aisheng-B29396; alsa-devel at alsa-project.org;
> s.hauer at pengutronix.de; lrg at ti.com; linux-arm-kernel at lists.infradead.org;
> w.sang at pengutronix.de
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> 
> On Tue, Aug 02, 2011 at 06:13:11PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > Like I've indicated several times now we should just get rid of the
> > > code or hide it from the rest of the subsystem, it's being too cute
> > > for vanishingly little value.  The register maps for these devices
> > > are usually at most 255 registers so the memory savings are really
> > > not meaningful.  I'm hoping the guys working with this device will
> > > find time to look at fixing things, but if not I'd imagine we'll get
> > > to it at some point in the release cycle.
> 
> > Well, there aren't so many drivers suffering from this bug, so a
> > temporary fix would be easy like below (totally untested).
> 
> If we're going to do something like this I'd preserve the driver
> interface that's there rather than fiddling with their reg_cache_sizes -
> half the trouble here is that the meaning of that has become a bit
> slippery, the current code used to be correct.
> 
Can we fix FLAT first since it is most used and let rbtree and LZO as before?
