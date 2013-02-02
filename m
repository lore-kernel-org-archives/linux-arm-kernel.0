From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 02 Feb 2013 21:27:38 +0400
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130202124533.GA2637@n2100.arm.linux.org.uk>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef>
 <2077c13e12314dc3adc8e5b653855da0@DFLE72.ent.ti.com>
 <20130201185959.GQ2244@beef> <20130202124533.GA2637@n2100.arm.linux.org.uk>
Message-ID: <510D4C8A.4050305@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-02-2013 16:45, Russell King - ARM Linux wrote:

> Now, CPPI is brand new code to arch/arm - always has been.  It post-dates
> the DMA engine API.  And it's been said many times about moving it to
> drivers/dma.  The problem is Sergei doesn't want to do it - he's anti the

    I *can't* do it, and I have denied all further responibility for it.

> DMA engine API for whatever reasons he can dream up.  He professes no

    I'm not dreaming anything up. Please understand that CPPI 4.1 is not just 
a normal DMA controller -- it's a complex of several devices with DMA 
controller being only one of them, and one that can't work autonomously but 
only thru the proxy of the queue manager. That queue manager stuff I found 
hard to fit into drivers/dma/ infrastructure. Myabe it was a honest mistake, 
of course.

> knowledge of my dislike for having it in arch/arm, yet there's emails
> from years back showing that he knew about it.  TI knows about it; Ajay
> about it.  Yet... well... history speaks volumes about this.

    Some details have slipped rom my memory after that many years. Im sorry 
for that.

> Now, there may be a new problem with CPPI.  That being we're now requiring
> DT support.  _Had_ this been done prior to the push for DT, then it would
> not have been a concern, because then the problem becomes one for DT.
> But now that OMAP is being converted to DT, and DT is The Way To Go now,
> that's an additional problem that needs to be grappled with - or it may
> make things easier.

    DaVinci is also being converted to device tree. However, that support 
remains optional for now. Not sure it will make things easier, as we still 
have two distinct devices to declare in the device tree: DMA controller and 
queue manager, and we'll have to describe the interconnect between them too 
(as a props of DMA controller I guess)...

WBR, Sergei
