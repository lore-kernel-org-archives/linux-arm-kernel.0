From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Mar 2015 09:49:57 +0100
Subject: [patch] spi: pxa2xx: missing break in pxa2xx_ssp_get_clk_div()
In-Reply-To: <1427712912.14897.441.camel@linux.intel.com>
References: <20150330103040.GB27144@mwanda>
 <1427712912.14897.441.camel@linux.intel.com>
Message-ID: <20150331084957.GJ2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 01:55:12PM +0300, Andy Shevchenko wrote:
> On Mon, 2015-03-30 at 13:30 +0300, Dan Carpenter wrote:

> > @@ -791,6 +791,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
> >  	switch (drv_data->ssp_type) {
> >  	case QUARK_X1000_SSP:
> >  		clk_div = quark_x1000_get_clk_div(rate, &chip->dds_rate);
> > +		break;
> >  	default:
> >  		clk_div = ssp_get_clk_div(drv_data, rate);

> It would be nice to have a break here as well, but I think we also may
> change this to if-else-if construction.

No.  Using if/else chains is an antipattern - think what happens when a
new hardware variant needs slightly different handling again.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150331/643da208/attachment.sig>
