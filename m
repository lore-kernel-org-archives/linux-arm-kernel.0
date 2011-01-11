From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 11 Jan 2011 19:39:52 +0800
Subject: [PATCH v4 07/10] ARM: mx28: add the second fec device registration
In-Reply-To: <20110111102909.GH26617@pengutronix.de>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294297998-26930-8-git-send-email-shawn.guo@freescale.com>
	<20110111102909.GH26617@pengutronix.de>
Message-ID: <20110111113951.GB2888@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jan 11, 2011 at 11:29:09AM +0100, Sascha Hauer wrote:
> On Thu, Jan 06, 2011 at 03:13:15PM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/mach-mx28evk.c |   28 +++++++++++++++++++++++++---
> >  1 files changed, 25 insertions(+), 3 deletions(-)
> > 
> >  
> >  static void __init mx28evk_init(void)
> > @@ -117,7 +136,10 @@ static void __init mx28evk_init(void)
> >  	mx28_add_duart();
> >  
> >  	mx28evk_fec_reset();
> > -	mx28_add_fec(0, &mx28_fec_pdata);
> > +	mx28_add_fec(0, &mx28_fec_pdata[0]);
> > +#ifdef CONFIG_FEC2
> > +	mx28_add_fec(1, &mx28_fec_pdata[1]);
> > +#endif
> 
> Please don't do this. If you really want to make this configurable with
> kconfig use a board specific option, not a driver specific option. I
> think this should be made unconditional though.
> 
I will resend this patch as v5 than the whole patch set, if you
do not mind.

-- 
Regards,
Shawn
