From: alvin.chen@intel.com (Chen, Alvin)
Date: Wed, 8 Oct 2014 00:46:58 +0000
Subject: [PATCH 1/2 v2] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
In-Reply-To: <1411980737.10697.0.camel@linux.intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-2-git-send-email-alvin.chen@intel.com>
 <1411980737.10697.0.camel@linux.intel.com>
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E997C28@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I'm okay with the current version, though I have few minor comments below.
> 
> > Introduce helper functions to access the 'SSCR0' and 'SSCR1'.
> >
> 
> Like you said in the summary there are many accessors to many registers, not
> only cr1/cr0. Perhaps, you may extend your commit message.
> 
OK.

> In any case
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
OK.
> > +
> >  /*
> >   * Read and write LPSS SSP private registers. Caller must first check that
> >   * is_lpss_ssp() returns true before these can be called.
> > @@ -234,7 +301,7 @@ static int null_writer(struct driver_data *drv_data)
> >  	void __iomem *reg = drv_data->ioaddr;
> >  	u8 n_bytes = drv_data->n_bytes;
> >
> > -	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
> > +	if (pxa2xx_spi_txfifo_full(drv_data)
> >  		|| (drv_data->tx == drv_data->tx_end))
> 
> Just wondering if those two could fit one line.
> 
No, if make the two in one line, it is 84 characters.
