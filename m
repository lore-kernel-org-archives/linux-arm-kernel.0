From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Sep 2016 14:16:42 +0300
Subject: [PATCH 2/4] drivers: iio: ti_am335x_adc: add dma support
In-Reply-To: <0cd3dfcc-2525-c2fb-35ab-1b260c5973a8@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-3-mugunthanvnm@ti.com>
 <1dbd7bbd-36ac-4433-79bf-8975a06dd07e@ti.com>
 <0cd3dfcc-2525-c2fb-35ab-1b260c5973a8@ti.com>
Message-ID: <30294b90-af44-d8cf-d70b-92a9461f1e5f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/16 13:45, Mugunthan V N wrote:
>>> +	if (!dma->chan)
>>> +		return -ENODEV;
>>> +
>>> +	/* RX buffer */
>>> +	dma->buf = dma_alloc_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
>>> +				      &dma->addr, GFP_KERNEL);
>>> +	if (!dma->buf)
>>> +		goto err;
>>> +
>>> +	dev_dbg_ratelimited(adc_dev->mfd_tscadc->dev, "got dma channel\n");
>>
>> Do we need _ratelimited? AFAICS, this print is called only once.
> 
> True, will change to dev_dbg.

It would be better to remove it. It gives no useful debuggin information apart
from the fact that the driver did not failed to probe.

-- 
P?ter
