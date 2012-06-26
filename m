From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 20:31:43 +0800
Subject: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
In-Reply-To: <201206261422.55005.marex@denx.de>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
 <1340477033-2761-7-git-send-email-marex@denx.de>
 <20120626074342.GA4928@S2101-09.ap.freescale.net>
 <201206261422.55005.marex@denx.de>
Message-ID: <20120626123141.GH8858@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 02:22:54PM +0200, Marek Vasut wrote:
> > > +static int __devexit mxs_spi_remove(struct platform_device *pdev)
> > > +{
> > > +	struct spi_master *host;
> > > +	struct mxs_ssp *ssp;
> > > +
> > > +	host = platform_get_drvdata(pdev);
> > > +	if (host)
> > > +		return 0;
> > 
> > Hmm, why the check and return here?
> 
> If it's not set, things went _very_ wrong somewhere. Maybe BUG_ON() might be 
> better?
> 
So shouldn't it be "if (!host)"?

And I still do not understand how that could happen.  I think
mxs_spi_remove will only be called in case that mxs_spi_probe
succeeds, which means platform_set_drvdata must have been called
already?

-- 
Regards,
Shawn
