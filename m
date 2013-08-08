From: zonque@gmail.com (Daniel Mack)
Date: Thu, 08 Aug 2013 10:38:45 +0200
Subject: [PATCH 06/12] dma: mmp_pdma: make the controller a DMA provider
In-Reply-To: <201308071812.15420.arnd@arndb.de>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <1375870770-14263-7-git-send-email-zonque@gmail.com>
 <201308071812.15420.arnd@arndb.de>
Message-ID: <52035915.50509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2013 18:12, Arnd Bergmann wrote:
> On Wednesday 07 August 2013, Daniel Mack wrote:

>> @@ -869,6 +874,19 @@ static int mmp_pdma_probe(struct platform_device *op)
>>  		return ret;
>>  	}
>>  
>> +	if (op->dev.of_node) {
>> +		mmp_pdma_info.dma_cap = pdev->device.cap_mask;
>> +
>> +		/* Device-tree DMA controller registration */
>> +		ret = of_dma_controller_register(op->dev.of_node,
>> +						 of_dma_simple_xlate,
>> +						 &mmp_pdma_info);
> 
> of_dma_simple_xlate can not be used if there is a chance that multiple instances
> of the same dma engine, or multiple different DMA engines are present in the
> system. I generally advise against using it.
> 
> Please have a look at the changes that Zhangfei Gao proposed in
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/249077
> and see if you can do the same here.

Ok, I'll rebase my series on top of that one, hoping that Zhangfei's
patch will make it upstream before mine.


Daniel
