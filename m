From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Dec 2013 14:51:16 +0100
Subject: [PATCH V6 3/3] ahci: imx: Add i.MX53 support
In-Reply-To: <20131210133723.GC26728@S2101-09.ap.freescale.net>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
 <20131210114738.GA4097@pengutronix.de>
 <20131210133723.GC26728@S2101-09.ap.freescale.net>
Message-ID: <201312101451.16910.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 10, 2013 at 02:37:27 PM, Shawn Guo wrote:
> On Tue, Dec 10, 2013 at 12:47:38PM +0100, Sascha Hauer wrote:
> > > @@ -34,10 +34,21 @@ enum {
> > > 
> > >  	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
> > >  
> > >  };
> > > 
> > > +enum ahci_imx_type {
> > > +	AHCI_IMX53,
> > > +	AHCI_IMX6Q,
> > > +};
> > 
> > Please next time introduce a SoC specific struct to encode the
> > differences between SoCs. This way you can abstract away the differences
> > in flags and function callbacks and don't end up with functions which
> > do completely different things for different SoCs like currently in
> > imx_sata_clock_enable(). The if (type == SOC_XY) style doesn't scale in
> > many drivers anymore.
> 
> Yea, I was thinking about the same thing when reviewing the patch in the
> first time, but decided to not comment on that because currently the
> added functions are doing the similar/related thing.  But I agree that
> SoC specific structure should be some thing more scalable and we should
> go for in the future.

Full ACK on this one, yes. Thus far, the chips are similar so that the ID is 
enough, once we get some more exotic chip, this should be changed to a 
structure. I guess the IOMUX register layout might be different on the MX7 at 
least for example ?

Best regards,
Marek Vasut
