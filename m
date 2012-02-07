From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 06 Feb 2012 21:24:15 -0800 (PST)
Subject: [PATCH 2/3] ARM: make disable_fiq macro optional
In-Reply-To: <4F30B225.60605@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-3-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1202061424130.1656@xanadu.home> <4F30B225.60605@gmail.com>
Message-ID: <alpine.LFD.2.02.1202062116210.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Feb 2012, Rob Herring wrote:

> Nicolas,
> 
> On 02/06/2012 04:34 PM, Nicolas Pitre wrote:
> > On Mon, 6 Feb 2012, Rob Herring wrote:
> > 
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> Only rpc uses disable_fiq, so make its use conditional on ARCH_RPC.
> >>
> >> With this, entry-macro.S is no longer needed for platforms that
> >> select MULTI_IRQ_HANDLER and the include of it can be conditional.
> > 
> > Using set_fiq_handler() in the rpc boot code we could get rid of 
> > disable_fiq entirely.
> > 
> 
> That's already being done here:
> arch/arm/mach-rpc/dma.c:290:    set_fiq_handler(fiqhandler_start,
> fiqhandler_length);
> 
> Can the macro just be deleted? Or a default handler needs to be setup
> earlier?

That's the handler installed by the RPC DMA code.  Another one is needed 
by default for when that code is not active.


Nicolas
