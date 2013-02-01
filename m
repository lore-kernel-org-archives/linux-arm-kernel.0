From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 02 Feb 2013 03:10:24 +0400
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130201205600.GA31762@arwen.pp.htv.fi>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi> <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
Message-ID: <510C4B60.20802@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-02-2013 0:56, Felipe Balbi wrote:

>>> good point, do you wanna send some patches ?

>>     I have already sent them countless times and even stuck CPPI 4.1 support (in
>> arch/arm/common/cppi41.c) in Russell's patch system. TI requested to remove the
>> patch. :-(

> sticking into arch/arm/common/ wasn't a nice move.

    Like with EDMA we have nothing else to do with CPPI 4.1 being shared by 
DaVinci-like and OMAP-like SOCs. Thank TI for creatring this mess. And 
actually even that is not a good place since I think I know of a MIPS SoC 
having CPPI 4.1 as well, just out of tree.

 > But then again, so
 > wasn't asking for the patch to be removed :-s

    Unfortunately, Russell has done it -- all that was discuseed without me in 
the loop even. :-/

>>> I guess to make the MUSB side simpler we would need musb-dma-engine glue
>>> to map dmaengine to the private MUSB API. Then we would have some
>>> starting point to also move inventra (and anybody else) to dmaengine
>>> API.

>>     Why? Inventra is a dedicated device's private DMA controller, why make
>> universal DMA driver for it?

> because it doesn't make sense to support multiple DMA APIs. We can check
> from MUSB's registers if it was configured with Inventra DMA support and
> based on that we can register MUSB's own DMA Engine to dmaengine API.

     I still disagree. IMO drivers/dma/ is for standalone DMA engines. Else we 
could stick every bus mastering device's DMA engines there. CPPI 4.1 is in 
design standlone DMA engine, despite all in-tree implementations having it as 
subblock of MUSB and serving only MUSB.

WBR, Sergei
