From: varkabhadram@gmail.com (Varka Bhadram)
Date: Wed, 23 Jul 2014 16:44:59 +0530
Subject: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <b1778af62e7b42b39381fb2699b34eb1@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>	<1406103883-3572-2-git-send-email-yao.yuan@freescale.com>
 <20140723114834.411f6bb4@ipc1.ka-ro>
 <b1778af62e7b42b39381fb2699b34eb1@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <53CF9933.8030908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2014 04:41 PM, Yao Yuan wrote:
> Hi,
>
> Thanks for your review.
>
> Lothar Wa?mann wrote:
>> Yuan Yao wrote:
>>> Add dma support for i2c. This function depend on DMA driver.
>>> You can turn on it by write both the dmas and dma-name properties in dts node.
>>>
>>> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
>>> ---
>>>   drivers/i2c/busses/i2c-imx.c | 377
> [...]
>>> +
>>> +fail_rx:
>>> +	dma_release_channel(dma->chan_rx);
>>> +fail_tx:
>>> +	dma_release_channel(dma->chan_tx);
>>> +fail_al:
>>> +	devm_kfree(dev, dma);
>>>
>> No need for this one (that's the whole point of using devm_kzalloc())!
>>
> When DMA request failed, I2C will switch to PIO mode. So if the failed reason is just like DMA channel request failed. At this time the DMA should free by devm_kfree(). Is it?

If probe failed the memory will be freed automatically because
we are using devm_kzalloc()...

If we use devm_kzalloc() ,no need to free manually on fail...

-- 
Regards,
Varka Bhadram.
