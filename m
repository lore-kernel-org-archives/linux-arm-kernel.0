From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 11 Sep 2015 20:31:16 +0800
Subject: [PATCH v4 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
In-Reply-To: <20150911115331.GM12027@sirena.org.uk>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
 <1441502008-14116-1-git-send-email-shawn.lin@rock-chips.com>
 <20150911115331.GM12027@sirena.org.uk>
Message-ID: <55F2C994.4040007@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2015/9/11 19:53, Mark Brown ??:
> On Sun, Sep 06, 2015 at 09:13:28AM +0800, Shawn Lin wrote:
>
>> @@ -460,7 +463,6 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>>   	i2s->playback_dma_data.addr = res->start + I2S_TXDR;
>>   	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>   	i2s->playback_dma_data.maxburst = 4;
>> -
>>   	i2s->capture_dma_data.addr = res->start + I2S_RXDR;
>>   	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>   	i2s->capture_dma_data.maxburst = 4;
>
> This random whitespace change shouldn't be in here.

yes, sorry for this bit.

>
>> @@ -489,6 +491,18 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>>   		goto err_pcm_register;
>>   	}
>>
>> +	dma_quirk = snd_dmaengine_pcm_get_quirks(&pdev->dev);
>> +	if (dma_quirk == ROCKCHIP_I2S_BROKEN_BURST_LEN) {
>> +		/*
>
> I'd expect this to be a switch statement given the way this is written.

Ahh.. agreed, but we don't expect more quriks for this driver.  ??)))
Will be done for the next version.

Thanks.

>


-- 
Best Regards
Shawn Lin
