From: zonque@gmail.com (Daniel Mack)
Date: Thu, 08 Aug 2013 12:14:36 +0200
Subject: [PATCH 01/20] mtd: pxa3xx-nand: replace pxa_request_dma with
 dmaengine
In-Reply-To: <20130808101221.GC2295@localhost>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-2-git-send-email-zonque@gmail.com>
 <20130807174612.GB18567@localhost> <52033DE1.5050700@gmail.com>
 <20130808101221.GC2295@localhost>
Message-ID: <52036F8C.2060104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2013 12:12, Ezequiel Garcia wrote:
> On Thu, Aug 08, 2013 at 08:42:41AM +0200, Daniel Mack wrote:
>> On 07.08.2013 19:46, Ezequiel Garcia wrote:
>>> Hi Daniel,
>>>
>>> On Wed, Aug 07, 2013 at 05:33:50PM +0200, Daniel Mack wrote:
>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>
>>>> [zonque at gmail.com: rebased in top of l2-mtd.git. The newly introduced
>>>> ARCH_HAS_DMA hack was changed into a check for CONFIG_HAS_DMA]
>>>>
>>>
>>> Are you sure you need to introduce the CONFIG_HAS_DMA ifdef?
>>>
>>> The reason I introduced the ARCH_HAS_DMA macro was to avoid including
>>> the "mach/dma.h" header. Now that you've removed it, I don't think
>>> this driver can be used in any platform where CONFIG_HAS_DMA=n.
>>
>> Well, yes it can, or at least you could decide to use it without DMA on
>> PXA/MMP. The idea of CONFIG_HAS_DMA is to save binary size.
>>
> 
> Ok, I see.
> 
> I think maybe we will have to add something to force use_dma=0
> when "armada370-nand" is used. AFAIK, the dmaengine does not support
> the kind of DMA operations this driver needs.

What kind of operation is that?

> I can take care of that if this patchset hits mainline before
> we have something really usable for Armada 370/XP NAND.

Ok :)


Daniel
