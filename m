From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Tue, 2 Aug 2011 11:15:28 +0000
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <s5hoc08nk7t.wl%tiwai@suse.de>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai at suse.de]
> Sent: Tuesday, August 02, 2011 7:09 PM
> To: Dong Aisheng-B29396
> Cc: Mark Brown; alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> lrg at ti.com; linux-arm-kernel at lists.infradead.org; w.sang at pengutronix.de
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> 
> > > reg_cache_size is supposed to be the real size of the cache table.
> > > This isn't influenced by reg_cache_step value.  So, the behavior in
> > > soc- io.c (and other ASoC core) is correct.
> > But the reg is related to step.
> > So reg and reg_cache_size are un-match when step > 1, right?
> 
> I'm not sure what is referred here as reg, but the argument passed to
> snd_soc_{read|write}() is the raw register index.  reg = 2 is 2 no matter
> whether reg_cache_step is 1 or 2.  This is passed down to hw_read(), thus
> reg and reg_cache_size do match even when step > 1.
> 
Yes, it is raw register index here.
The case is that cache array is [reg0, reg1, reg2, reg3],
So the size is 4.
But when step is 2, reg0 is 0x0, reg1 is 0x2, reg3 is 0x6.
So check if reg3 > reg_cache_size is not correct.
I mean this mismatch. Am I correct?

Regards
Dong Aisheng
