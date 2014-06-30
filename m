From: a.heider@gmail.com (Andre Heider)
Date: Mon, 30 Jun 2014 21:42:40 +0200
Subject: [PATCH 02/13] uio: uio_pruss: use devm_kzalloc()
In-Reply-To: <20140630093809.GW7262@leverpostej>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-3-git-send-email-a.heider@gmail.com>
 <20140630093809.GW7262@leverpostej>
Message-ID: <20140630194240.GD78749@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 10:38:09AM +0100, Mark Rutland wrote:
> On Sun, Jun 29, 2014 at 05:21:36PM +0100, Andre Heider wrote:
> > --- a/drivers/uio/uio_pruss.c
> > +++ b/drivers/uio/uio_pruss.c
> > @@ -109,9 +109,7 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
> >  		gen_pool_free(gdev->sram_pool,
> >  			      gdev->sram_vaddr,
> >  			      sram_pool_sz);
> > -	kfree(gdev->info);
> >  	clk_put(gdev->pruss_clk);
> > -	kfree(gdev);
> >  }
> >  
> >  static int pruss_probe(struct platform_device *pdev)
> > @@ -123,24 +121,19 @@ static int pruss_probe(struct platform_device *pdev)
> >  	int ret = -ENODEV, cnt = 0, len;
> >  	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
> >  
> > -	gdev = kzalloc(sizeof(struct uio_pruss_dev), GFP_KERNEL);
> > +	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);
> 
> If this is changing anyway, how about:
> 
> 	gdev = devm_kzalloc(dev, sizeof(*gdev), GFP_KERNEL);
> 

Sounds good, will do just that.

Thanks for having at look at the series, Mark!

Regards,
Andre
