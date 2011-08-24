From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 24 Aug 2011 11:08:15 +0000
Subject: [PATCH 1/2] ASoC: mxs-saif: add record function
In-Reply-To: <20110822113054.GC2006@pengutronix.de>
References: <1313942545-21403-1-git-send-email-b29396@freescale.com>
	<20110822113054.GC2006@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772223F4A@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Monday, August 22, 2011 7:31 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org;
> broonie at opensource.wolfsonmicro.com; lrg at ti.com; s.hauer at pengutronix.de
> Subject: Re: [PATCH 1/2] ASoC: mxs-saif: add record function
> 
> On Mon, Aug 22, 2011 at 12:02:25AM +0800, Dong Aisheng wrote:
> > 1. add different clkmux mode handling for record.
> > SAIF can use two instances to implement full duplex (playback &
> > recording) and record saif may work on EXTMASTER mode that is using
> > other saif's BITCLK&LRCLK.
> > The clkmux mode is determined by saif's platform data and machine
> > specific clkmux setting is done in pdata->init().
> > 2. support playback and capture simutaneously however the sample rates
> > can not be different due to hw limitation.
> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> 
> Will test and review, but probably not before Wednesday.
> 

If you want to test, you may need to apply another sgtl5000 patch
to fix noise issue.

BTW, since MX28EVK only has line-in (no mic-in), i just tested by
capturing data from line-in and connected the line-in to a PC's
Headphone output.

Not sure if there might be some issue due to line-in level is a
little different from headphone out level.
(Any comments from the person who knows?)

Anyway, it just sounds well at my side.

The patch for your reference:
It's just for testing and I'm going to check it with our ic people
for the root cause.

Regards
Dong Aisheng
