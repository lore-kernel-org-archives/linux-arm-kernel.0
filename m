From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Aug 2010 10:27:59 +0100
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by
	"ARM: Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <201008101045.03547.philippe.retornaz@epfl.ch>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
Message-ID: <20100810092759.GB31759@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 10:45:03AM +0200, Philippe R?tornaz wrote:
> Le dimanche, 8 ao?t 2010 17.45:26, Arnd Hannemann a ?crit :
> > Hi Russell,
> > 
> > your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> > ARM: Prohibit ioremap() on kernel managed RAM
> > 
> > lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> > fail for the sh_mobile_ceu_camera driver (see backtrace below).
> > I think, other configurations (i.MX31 users of the mx3_camera driver:
> > pcm037 and mx31moboard) will have the same problem.
> > 
> > Since I have no idea how to fix this, I post this regression report here...
> 
> Have you found a solution to this problem ? As you said, the mx3_camera driver 
> doesn't work anymore on mx31moboard.

MX3 is ARMv6 which has the architectural restriction as well I'm afraid.
