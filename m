From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 02 Feb 2013 04:01:37 +0400
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130201185959.GQ2244@beef>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef>
 <2077c13e12314dc3adc8e5b653855da0@DFLE72.ent.ti.com>
 <20130201185959.GQ2244@beef>
Message-ID: <510C5761.7050401@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2013 22:59, Matt Porter wrote:

>>>>> Move mach-davinci/dma.c to common/edma.c so it can be used
>>>>> by OMAP (specifically AM33xx) as well.

>>>> I think this should rather go to drivers/dma/?

>>> No, this is the private EDMA API. It's the analogous thing to
>>> the private OMAP dma API that is in plat-omap/dma.c. The actual
>>> dmaengine driver is in drivers/dma/edma.c as a wrapper around
>>> this...same way OMAP DMA engine conversion is being done.

>>    Keeps me wondering why we couldn't have the same with CPPI 4.1 when I proposed
>> that, instead of waiting indefinitely for TI to convert it to drivers/dma/
>> directly. We could have working MUSB DMA on OMAP-L1x/Sitara all this time... Sigh.

> That is a shame. Yeah, I've pointed out that I was doing this exactly
> the same way as was acceptable for the OMAP DMA conversion since it was
> in RFC. The reasons are sound since in both cases, we have many drivers
> to convert that need to continue using the private DMA APIs.

    In case of CPPI 4.1, we'd only have to convert MUSB DMA driver. Other 
in-tree CPPI 4.1 having SoCs don't use it for anything but MUSB -- it even is 
sub-block of their MUSB device, AFAIK (I maybe wrong about Sitaras -- I don't 
know them well).

> -Matt

WBR, Sergei
