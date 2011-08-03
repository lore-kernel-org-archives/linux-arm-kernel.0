From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 3 Aug 2011 07:03:54 +0000
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110803052333.GA16141@opensource.wolfsonmicro.com>
References: <65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
	<20110802164005.GI25884@opensource.wolfsonmicro.com>
	<s5h4o1zsn6o.wl%tiwai@suse.de>
	<20110803052333.GA16141@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F4ED6@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: Wednesday, August 03, 2011 1:24 PM
> To: Takashi Iwai
> Cc: Dong Aisheng-B29396; alsa-devel at alsa-project.org;
> s.hauer at pengutronix.de; lrg at ti.com; linux-arm-kernel at lists.infradead.org;
> w.sang at pengutronix.de
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> 
> On Tue, Aug 02, 2011 at 08:06:23PM +0200, Takashi Iwai wrote:
> 
> > example.  So, alternatively, we can put the condition in some generic
> > filter function like readable/writeble things.
> 
> Yes, I suggested that already, these are just unreadable and unwritable
> registers :/

For padded cache array, the unreadable & unwritable function is correct
as Takashi indicated accessing the odd number of register index is invalid with
step = 2.
But for packed cache array...

There's a few confuse on the using of reg_cache_size and reg_cache_step
in current kernel. 
(like some drivers use packed cache while some use padded)

Maybe we need to first unify it.
