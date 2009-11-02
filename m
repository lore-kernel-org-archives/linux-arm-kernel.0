From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 02 Nov 2009 18:14:20 +0100
Subject: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
	at91sam9g45 chip and board
In-Reply-To: <4AE55A93.1080106@visionsystems.de>
References: <20090930155557.7dae503b@hskinnemoen-d830>
	<a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
	<4AE55A93.1080106@visionsystems.de>
Message-ID: <4AEF136C.8020005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yegor Yefremov :
> Nicolas Ferre wrote:
>> This adds the support of atmel-mci sd/mmc driver in at91sam9g45 devices and
>> board files. This also configures the DMA controller slave interface for
>> at_hdmac dmaengine driver.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

[..]

>> +	/* DMA slave channel configuration */
>> +	slave->sdata.dma_dev = &at_hdmac_device.dev;
>> +	slave->sdata.reg_width = DW_DMA_SLAVE_WIDTH_32BIT;
> 
> slave->sdata.reg_width = AT_DMA_SLAVE_WIDTH_32BIT;
> 
>> +	slave->sdata.cfg = ATC_FIFOCFG_HALFFIFO
>> +			 | ATC_SRC_H2SEL_HW | ATC_DST_H2SEL_HW;

Queued for v3 of this patch (I will dissociate if from the patch series).


> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Ok, I will add.

Thanks a lot.

Best regards,
-- 
Nicolas Ferre
