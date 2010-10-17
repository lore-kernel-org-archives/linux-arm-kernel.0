From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Sun, 17 Oct 2010 08:05:35 -0500
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <1287196588.2370.1.camel@pasglop>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<1287196588.2370.1.camel@pasglop>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203D76F71F4@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Benjamin
> Herrenschmidt

> > If you want the old way back, apply pressure to silicon vendors and
> > ARM Ltd to change the architecture to lift this restriction - which
> > will probably mean doing away with aggressive speculative
> prefetching
> > so that it's possible to predict what will be in the cache at any
> > point in time.
>
> Note that we have the exact same problem on powerpc. The only sane
> solution is that SoCs designed around such cores or versions of the
> architecture should be fully DMA coherent to avoid the need for funky
> mapping attributes. Anything else is garbage HW, but sadly, it looks
> like way too many idiots still find jobs as HW designers.

ARM has always been a rawer (and cheaper) environment than many other CPU architectures. Until maybe this year coherency was never even an option provided in the hardware. The vast majority of the systems currently in mass production in 2010 and before don't have coherency.  The software has to handle all the details.

Starting today and onwards coherency options will start to be seen in high end. It seems likely some of the old external IP won't be compliant and likely have bugs undercutting it.

People from high ends like x86 and PPC have different expectations and problems. Your chip set nightmares are our standard in some areas. In my narrow experience PPC pioneered many techniques 15 years back which are now just coming into ARM. They are coming in at a much reduced power and cost footprint.

Regards,
Richard W.
