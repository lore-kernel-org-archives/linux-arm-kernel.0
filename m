From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 15:10:43 +0200
Subject: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
 compliant with UHS-1
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
 <20140425123820.GA15179@pengutronix.de>
 <20140425124945.GM26756@n2100.arm.linux.org.uk>
 <20140425130849.GB15179@pengutronix.de>
 <20140425131529.GN26756@n2100.arm.linux.org.uk>
 <20140425132245.GO26756@n2100.arm.linux.org.uk>
Message-ID: <20140428131043.GD15179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 25, 2014 at 02:22:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 25, 2014 at 02:15:30PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Apr 25, 2014 at 03:08:49PM +0200, Markus Pargmann wrote:
> > > I just tried the different parts of the patch. Without the following
> > > change, emmc works:
> > > 
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
> > >  			host->ops->set_clock(host, host->clock);
> > >  		}
> > >  
> > > -
> > > -		/* Reset SD Clock Enable */
> > > -		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > -		clk &= ~SDHCI_CLOCK_CARD_EN;
> > > -		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > -
> > 
> > So the bit which stops us violating the SD spec stops eMMC from working...
> > that's... just great.
> > 
> > Okay, I'll look deeper at this and see what can be done, but I suspect it
> > will turn out to require more patches and be more invasive.
> 
> In the mean time, here's the remainder (to patch 33) of the series with
> this commit omitted.

I tested the whole series again, from 1 to patch 32 and it is working
correctly now on the RIoT board (imx6s) with emmc and sd-card. You can
add my tested-by tag for all core and imx related patches if you want to.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/67e1f8c6/attachment.sig>
