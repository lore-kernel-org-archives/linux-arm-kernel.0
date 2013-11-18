From: florian.meier@koalo.de (Florian Meier)
Date: Mon, 18 Nov 2013 15:37:01 +0100
Subject: [PATCHv7] dmaengine: Add support for BCM2835
In-Reply-To: <1384785017.14845.214.camel@smile>
References: <5288E327.8050809@koalo.de> <1384768816.14845.186.camel@smile>	
 <528A051A.7000703@koalo.de> <1384785017.14845.214.camel@smile>
Message-ID: <528A260D.7090807@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>> +static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
>>>> +	dma_cookie_t cookie, struct dma_tx_state *txstate)
>>>> +{
>>>
>>> []
>>>
>>>> +	} else {
>>>> +		txstate->residue = 0;
>>>
>>> Useless assignment since dmaengine will do this for you in
>>> dma_cookie_status.
>>
>> I agree that it is useless, but I think otherwise it might be concealed
>> that there is a third case left that uses a residue of 0. Do you think a
>> comment is better? E.g.:
>>
>> +	} else {
>> +		/* residue = 0 per default */
> 
> I think like in many other DMA drivers either you have separate function
> to get residue, which returns 0, or just not include this case.

You mean like in the omap-dma.c? ;-P

>>>> +static int bcm2835_dma_probe(struct platform_device *pdev)
>>>> +{
> 
>>>> +	uint32_t chans_available;
>>>
>>> Why uint32_t?
>>
>> Because it is a bit mask of fixed length that directly comes from the
>> firmware.
> 
> Like one already told you in your i2s patch, please, change that to
> corresponding u* value, namely u32.

I have no problem with changing that, but why?
