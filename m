From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon, 6 Aug 2018 17:22:59 +0800
Subject: [PATCH v2 3/9] dmaengine: st_fdma: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <a2d2f8d5-95a7-f511-24e6-6d43228de2a6@zonque.org>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
 <20180806085231.4597-4-sjhuang@iluvatar.ai>
 <a2d2f8d5-95a7-f511-24e6-6d43228de2a6@zonque.org>
Message-ID: <20180806092252.GA5301@hsj-Precision-5520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 11:03:51AM +0200, Daniel Mack wrote:
> > -	ret = dma_async_device_register(&fdev->dma_device);
> > +	ret = dmaenginem_async_device_register(&fdev->dma_device);
> >   	if (ret) {
> >   		dev_err(&pdev->dev,
> >   			"Failed to register DMA device (%d)\n", ret);
> > @@ -852,7 +852,6 @@ static int st_fdma_probe(struct platform_device *pdev)
> >   	return 0;
> >   err_dma_dev:
> > -	dma_async_device_unregister(&fdev->dma_device);
> 
> I guess the jump label can go away too?
Yes. 

We can remove the err_dma_dev too.

Thanks
Huang Shijie
