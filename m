From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 3 Aug 2011 11:11:18 +0000
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110803093140.GB30782@opensource.wolfsonmicro.com>
References: <65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
	<20110802164005.GI25884@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F4F43@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110803093140.GB30782@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F5223@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: Wednesday, August 03, 2011 5:32 PM
> To: Dong Aisheng-B29396
> Cc: Takashi Iwai; alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> lrg at ti.com; linux-arm-kernel at lists.infradead.org; w.sang at pengutronix.de
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> 
> On Wed, Aug 03, 2011 at 07:39:27AM +0000, Dong Aisheng-B29396 wrote:
> 
> > Can we fix FLAT first since it is most used and let rbtree and LZO as
> before?
> 
> Leaving rbtree and LZO alone is exactly what I've been saying!

Sorry for not catch your point before.

Do you think the my patch that provides a register and cache index conversion
helper function behind for FLAT could be a way to try?

If yes, I can clean my patch to only include FLAT fix and send it out for
You to take a look.

Using this method, codec driver does not need to pad the default cache array.
During the cache read, the register will be automatically converted to cache
index to fetch value.
This can also fix the soc_codec_reg_show for codecs who are using packed
(FLAT) Cache while step = 2.
(Here I assume the packed cache only has a different step with FLAT cache.
FIXME if wrong)
