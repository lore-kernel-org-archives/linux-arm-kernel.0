From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Dec 2010 11:37:06 +0100
Subject: [RFC PATCH] scatterlist: Initialize the dma_address field with
	invalid dma address
In-Reply-To: <20101209.120006.189701386.davem@davemloft.net>
References: <1291900514-7290-1-git-send-email-nicolas.ferre@atmel.com>
	<20101209.120006.189701386.davem@davemloft.net>
Message-ID: <4D0202D2.8010208@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/12/2010 21:00, David Miller :
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> Date: Thu,  9 Dec 2010 14:15:14 +0100
> 
>> Initialize the the dma_address field so that it will be possible to test
>> its value while using scatterlists. This field will be compatible with
>> testing by dma_mapping_error().
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Please don't do this, it's unjustified and it's going to kill performance.

Yes, that is what I suspected...

> Even if it were a good change, you should have used the invalid DMA
> address definition defined by various architectures instead of a constant.

Well this definition seems to be spread among drivers (mostly usb ones):
DMA_ADDR_INVALID...
And also sometimes with different names:
DMA_INVALID_HANDLE, INVALID_DMA_ADDRESS

> You should be aware of whether entries in a scatterlist have been setup
> by your code path.

Yes, in fact my need is related to the fact that my scatterlist is
filled in a driver and then handled by the dmaengine driver.
But I will reconsider the path taken by my sg to be able to avoid
checking the dma_address field.

Best regards,
-- 
Nicolas Ferre
