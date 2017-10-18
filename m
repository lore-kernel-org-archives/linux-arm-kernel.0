From: tpiepho@impinj.com (Trent Piepho)
Date: Wed, 18 Oct 2017 17:30:10 +0000
Subject: [PATCH 3/4] spi: imx: Don't require platform data chipselect array
In-Reply-To: <36d381de-ee3f-26d4-59c3-b9d361758ace@arm.com>
References: <20171013195410.30767-1-tpiepho@impinj.com>
 <20171013195410.30767-3-tpiepho@impinj.com>
 <36d381de-ee3f-26d4-59c3-b9d361758ace@arm.com>
Message-ID: <1508347809.87493.2.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-18 at 10:02 +0100, Julien Thierry wrote:
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -1364,13 +1364,15 @@ static int spi_imx_probe(struct platform_device *pdev)
> >   
> >   	if (mxc_platform_info) {
> >   		master->num_chipselect = mxc_platform_info->num_chipselect;
> 
> nit:
> This is only useful when num_chipselect is non-zero (master's memory is 
> zeroed on allocation). So maybe this could be simplified a bit more as:
> 
> if (mxc_platform_info && mxc_platform_info->chipselect) {
> 	master->num_chipselect = mxc_platform_info->num_chipselect;
> 	[...]
> }
> 
> Reducing an indentation level for all the following statements.

Good point, there's nothing else in the platform info to use.
