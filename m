From: michael@walle.cc (Michael Walle)
Date: Sun, 3 Jun 2012 23:51:22 +0200
Subject: [PATCH] spi-orion: remove uneeded spi_info
In-Reply-To: <20120603210424.GM14756@titan.lakedaemon.net>
References: <1338754215-16022-1-git-send-email-michael@walle.cc>
 <20120603210424.GM14756@titan.lakedaemon.net>
Message-ID: <201206032351.22925.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Am Sonntag 03 Juni 2012, 23:04:24 schrieb Jason Cooper:
> On Sun, Jun 03, 2012 at 10:10:14PM +0200, Michael Walle wrote:
> > This was formerly used to store the tclk value. Remove it.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> > 
> >  drivers/spi/spi-orion.c |    5 -----
> >  1 files changed, 0 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> > index dfd04e9..2760450 100644
> > --- a/drivers/spi/spi-orion.c
> > +++ b/drivers/spi/spi-orion.c
> > @@ -45,7 +45,6 @@ struct orion_spi {
> > 
> >  	void __iomem		*base;
> >  	unsigned int		max_speed;
> >  	unsigned int		min_speed;
> > 
> > -	struct orion_spi_info	*spi_info;
> > 
> >  	struct clk              *clk;
> >  
> >  };
> > 
> > @@ -450,12 +449,9 @@ static int __init orion_spi_probe(struct
> > platform_device *pdev)
> > 
> >  	struct spi_master *master;
> >  	struct orion_spi *spi;
> >  	struct resource *r;
> > 
> > -	struct orion_spi_info *spi_info;
> > 
> >  	unsigned long tclk_hz;
> >  	int status = 0;
> > 
> > -	spi_info = pdev->dev.platform_data;
> > -
> > 
> >  	master = spi_alloc_master(&pdev->dev, sizeof *spi);
> >  	if (master == NULL) {
> >  	
> >  		dev_dbg(&pdev->dev, "master allocation failed\n");
> > 
> > @@ -476,7 +472,6 @@ static int __init orion_spi_probe(struct
> > platform_device *pdev)
> > 
> >  	spi = spi_master_get_devdata(master);
> >  	spi->master = master;
> > 
> > -	spi->spi_info = spi_info;
> > 
> >  	spi->clk = clk_get(&pdev->dev, NULL);
> 
> It's not relevant to this patch, but later in the patch series, you
> initialize this device via devicetree.  Did you add the clock node?  Is
> there a dependency for this series that I missed?

i added the original device name by using the auxdata in 
of_platform_populate(). See "[PATCH 2/3] ARM: kirkwood: use devicetree for 
orion-spi"

-- 
Michael
