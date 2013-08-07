From: zonque@gmail.com (Daniel Mack)
Date: Wed, 07 Aug 2013 18:17:28 +0200
Subject: [PATCH 06/12] dma: mmp_pdma: make the controller a DMA provider
In-Reply-To: <201308071812.15420.arnd@arndb.de>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <1375870770-14263-7-git-send-email-zonque@gmail.com>
 <201308071812.15420.arnd@arndb.de>
Message-ID: <52027318.3080703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2013 18:12, Arnd Bergmann wrote:
> On Wednesday 07 August 2013, Daniel Mack wrote:

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
> system.

Both can't be the case really for PXA, but I see your point.

> Please have a look at the changes that Zhangfei Gao proposed in
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/249077
> and see if you can do the same here.

Ok, I can do the same. As I can directly access dma_spec->args[0] from
that context, that approach would also solve the problem with the
hard-coded filter function, right?


Thanks,
Daniel
