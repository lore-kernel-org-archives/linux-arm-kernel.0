From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 13 Dec 2010 16:19:41 +0800
Subject: [PATCH v5 07/15] ARM: mxs: Add gpio support
In-Reply-To: <20101213081021.GA23591@ubuntu.localdomain>
References: <1291968402-19393-1-git-send-email-shawn.guo@freescale.com>
	<1291968402-19393-2-git-send-email-shawn.guo@freescale.com>
	<20101210102416.GH17441@pengutronix.de>
	<20101213072743.GA23558@ubuntu.localdomain>
	<20101213075738.GA26210@pengutronix.de>
	<20101213081021.GA23591@ubuntu.localdomain>
Message-ID: <20101213081940.GB23591@ubuntu.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 01:10:22AM -0700, Guo Shawn-R65073 wrote:
> On Mon, Dec 13, 2010 at 12:57:38AM -0700, Uwe Kleine-K?nig wrote:
> > Hi Shawn,
> > 
> > On Mon, Dec 13, 2010 at 03:28:14PM +0800, Shawn Guo wrote:
> > > On Fri, Dec 10, 2010 at 03:24:16AM -0700, Uwe Kleine-K?nig wrote:
> > > > On Fri, Dec 10, 2010 at 04:06:40PM +0800, Shawn Guo wrote:
> > > > > +		__raw_writel(~0, port[i].base +
> > > > > +				PINCTRL_IRQSTAT(i) + MXS_CLR_ADDR);
> > > > Why not __raw_writel(0, port[i].base + PINCTRL_IRQSTAT(i)) ?
> > > > (And note that applying ~ on a signed integer isn't portable in
> > > > general.  For all sane archs this is the same as ~0U though and ARM is
> > > > sane (here), still I think it's good to be aware of such things and
> > > > avoid them if easily possible.)
> > > > 
> > > The i.MX28 RM section 9.4.78 tells "Software may clear any bit in this
> > > register by writing a 1 to the bit at the SCT clear address".
> > I didn't say that __raw_writel(~0,  ... + MXS_CLR_ADDR) didn't work.
> > It's just that I consider writing a 0 directly into the PINCTRL_IRQSTAT
> > register a bit more clear.
> >  
> I thought software has to clear bit by writing clear address for this
> register. Just confirmed with designer it's not necessary, writing 0
> to register has the same effect as writing 1 to clear address.
> 
> So Uwe, Lothar, your suggestion is being taken.  Thanks.
> 
I have to say sorry, as the designer just said the same word to me.
He took it for granted that writing 0 to the address can also clear
the status. But after checking the RTL code, he told me that
only writing clear address will work.

Regards,
Shawn
