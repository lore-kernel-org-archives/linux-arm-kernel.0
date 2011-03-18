From: b32955@freescale.com (Huang Shijie)
Date: Fri, 18 Mar 2011 14:12:12 +0800
Subject: [PATCH 6/7] dmaengine: change the flags of request_irq()
In-Reply-To: <19840.36172.759509.889358@ipc1.ka-ro>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>	<1300239773-4222-7-git-send-email-b32955@freescale.com>
	<19840.36172.759509.889358@ipc1.ka-ro>
Message-ID: <4D82F7BC.4040703@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI:
> Hi,
>
> Huang Shijie writes:
>> The GPMI may have many DMA channels, such as the imx23 has
>> four DMA channels. All these DMA channels share the same interrupt.
>> So change the flags from '0' to IRQF_SHARED, else there will be
>> an EBUSY error returns.
>>
> Problem is, that the mxs_dma_int_handler() need to be rewritten
> for that since it currently does not support shared interrupts (as you
> can easily find out by enabling CONFIG_DEBUG_SHIRQ.
>
>
>
I enabled the CONFIG_DEBUG_SHIRQ, and I tested in imx23, the code is ok.
So I think there is no need to rewritten the mxs_dma_int_handler().


Btw: The missing patch can be found the MTD maillist archive:
http://lists.infradead.org/pipermail/linux-mtd/2011-March/034379.html



Best Regards
Huang Shijie
