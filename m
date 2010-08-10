From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 10 Aug 2010 21:55:29 +0200 (CEST)
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by "ARM:
	Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <20100810092759.GB31759@n2100.arm.linux.org.uk>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.1008102117000.18934@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:

> On Tue, Aug 10, 2010 at 10:45:03AM +0200, Philippe R?tornaz wrote:
> > Le dimanche, 8 ao?t 2010 17.45:26, Arnd Hannemann a ?crit :
> > > Hi Russell,
> > > 
> > > your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> > > ARM: Prohibit ioremap() on kernel managed RAM
> > > 
> > > lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> > > fail for the sh_mobile_ceu_camera driver (see backtrace below).
> > > I think, other configurations (i.MX31 users of the mx3_camera driver:
> > > pcm037 and mx31moboard) will have the same problem.
> > > 
> > > Since I have no idea how to fix this, I post this regression report here...
> > 
> > Have you found a solution to this problem ? As you said, the mx3_camera driver 
> > doesn't work anymore on mx31moboard.
> 
> MX3 is ARMv6 which has the architectural restriction as well I'm afraid.

So, if I understand this right, you cannot call 
dma_declare_coherent_memory() on already mapped RAM on ARM. So, to use 
this on physical RAM we have to remove it from the kernel mapping? Would 
using the "memmap=" kernel parameter suffice? Or is there a better 
solution for this?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
