From: MNARANI@xilinx.com (Manish Narani)
Date: Mon, 23 Jul 2018 09:27:03 +0000
Subject: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while
 requesting irq
In-Reply-To: <32791313-d317-c9c3-0760-34d4a4a691f9@metafoo.de>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
 <32791313-d317-c9c3-0760-34d4a4a691f9@metafoo.de>
Message-ID: <SN6PR02MB4959DB7E5C4D148D21F81E42C1560@SN6PR02MB4959.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
> Sent: Thursday, July 19, 2018 10:08 PM
> To: Manish Narani <MNARANI@xilinx.com>; jic23 at kernel.org;
> knaack.h at gmx.de; pmeerw at pmeerw.net; Michal Simek
> <michals@xilinx.com>; linux-iio at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> <sgoud@xilinx.com>
> Subject: Re: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while requesting
> irq
> 
> > @@ -1310,7 +1308,6 @@ static int xadc_remove(struct platform_device
> > *pdev)  {
> >  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >  	struct xadc *xadc = iio_priv(indio_dev);
> > -	int irq = platform_get_irq(pdev, 0);
> >
> >  	iio_device_unregister(indio_dev);
> >  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) { @@ -1318,7 +1315,6
> @@
> > static int xadc_remove(struct platform_device *pdev)
> >  		iio_trigger_free(xadc->convst_trigger);
> >  		iio_triggered_buffer_cleanup(indio_dev);
> >  	}
> > -	free_irq(irq, indio_dev);
> 
> This opens up a race condition. The IRQ needs to be freed before any of these
> other things below the free_irq() are executed.
Will look into it and send with taking care of the same.

> 
> >  	clk_disable_unprepare(xadc->clk);
> >  	cancel_delayed_work(&xadc->zynq_unmask_work);
> >  	kfree(xadc->data);
> >

Thanks,
Manish
