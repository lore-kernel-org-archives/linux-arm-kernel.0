From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jul 2017 13:34:06 +0530
Subject: [PATCH v2 2/4] dmaengine: Add STM32 MDMA driver (fwd)
In-Reply-To: <alpine.DEB.2.20.1707080813400.1971@hadrien>
References: <alpine.DEB.2.20.1707080813400.1971@hadrien>
Message-ID: <20170721080405.GQ3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 08, 2017 at 08:14:51AM +0200, Julia Lawall wrote:
> Please check on the comparison on line 1489.
> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Sat, 8 Jul 2017 10:13:09 +0800
> From: kbuild test robot <fengguang.wu@intel.com>
> To: kbuild at 01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [PATCH v2 2/4] dmaengine: Add STM32 MDMA driver
> 
> Hi Pierre-Yves,
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.12 next-20170707]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/Add-STM32-MDMA-driver/20170708-013345
> :::::: branch date: 9 hours ago
> :::::: commit date: 9 hours ago
> 
> >> drivers/dma/stm32-mdma.c:1489:5-16: WARNING: Unsigned expression compared with zero: dmadev -> irq < 0
> 
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout c6b3687d964d5a49aa0f297918bf26f6cb7444db
> vim +1489 drivers/dma/stm32-mdma.c
> 
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1473  		BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1474  	dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1475  		BIT(DMA_MEM_TO_MEM);
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1476  	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1477  	dd->max_burst = STM32_MDMA_MAX_BURST;
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1478  	dd->dev = &pdev->dev;
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1479  	INIT_LIST_HEAD(&dd->channels);
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1480
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1481  	for (i = 0; i < dmadev->nr_channels; i++) {
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1482  		chan = &dmadev->chan[i];
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1483  		chan->id = i;
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1484  		chan->vchan.desc_free = stm32_mdma_desc_free;
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1485  		vchan_init(&chan->vchan, dd);
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1486  	}
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1487
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1488  	dmadev->irq = platform_get_irq(pdev, 0);
> c6b3687d Pierre-Yves MORDRET 2017-07-06 @1489  	if (dmadev->irq < 0) {

This looks to be the case in current patchset too...

> c6b3687d Pierre-Yves MORDRET 2017-07-06  1490  		dev_err(&pdev->dev, "failed to get IRQ\n");
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1491  		return dmadev->irq;
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1492  	}
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1493
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1494  	ret = devm_request_irq(&pdev->dev, dmadev->irq, stm32_mdma_irq_handler,
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1495  			       0, dev_name(&pdev->dev), dmadev);
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1496  	if (ret) {
> c6b3687d Pierre-Yves MORDRET 2017-07-06  1497  		dev_err(&pdev->dev, "failed to request IRQ\n");
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
~Vinod
