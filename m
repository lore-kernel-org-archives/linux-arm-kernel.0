From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 22 Aug 2012 09:19:01 -0400 (EDT)
Subject: ioremap() fail on physical address 0x0 in 3.4 kernel
In-Reply-To: <20120822112339.GY18957@n2100.arm.linux.org.uk>
References: <50339AF6.1060601@codeaurora.org>
 <5033C428.2050607@codeaurora.org> <50348030.9080200@codeaurora.org>
 <20120822095302.GX18957@n2100.arm.linux.org.uk>
 <20120822112339.GY18957@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1208220918320.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Aug 2012, Russell King - ARM Linux wrote:

> On Wed, Aug 22, 2012 at 10:53:02AM +0100, Russell King - ARM Linux wrote:
> > @@ -826,7 +826,7 @@ static void __init fill_pmd_gaps(void)
> >  
> >  	/* we're still single threaded hence no lock needed here */
> >  	for (vm = vmlist; vm; vm = vm->next) {
> > -		if (!(vm->flags & VM_ARM_STATIC_MAPPING))
> > +		if (!(vm->flags & (VM_ARM_STATIC_MAPPING | VM_ARM_EMPTY_MAPPING))
> 
> Not forgetting the additional close paren needed here...

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
