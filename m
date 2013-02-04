From: balbi@ti.com (Felipe Balbi)
Date: Mon, 4 Feb 2013 19:02:16 +0200
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <510FF5C9.3030600@mvista.com>
References: <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi>
 <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi>
 <510FF5C9.3030600@mvista.com>
Message-ID: <20130204170216.GC4269@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 04, 2013 at 08:54:17PM +0300, Sergei Shtylyov wrote:
> > On Mon, Feb 04, 2013 at 08:36:38PM +0300, Sergei Shtylyov wrote:
> >>> opted out of it. From the top of my head we have CPPI 3.x, CPPI 4.1,
> >>> Inventra DMA, OMAP sDMA and ux500 DMA engines supported by the driver.
> 
> >>> Granted, CPPI 4.1 makes some assumptions about the fact that it's
> >>> handling USB tranfers,
> 
> >>    What CPPI 4.1 code makes this assumptions? MUSB DMA driver? Then it's just
> 
> > HW makes the asumptions
> 
>    Not true at all. There is a separate set of registers (at offset 0) which
> copes with USB specifics, but CPPI 4.1 itself doesn't know about USB anything.

CPPI 4.1 was made for USB transfers.

> It's just the way the driver was written that it used both sets of registers but
> this needs to be changed into more abstacted accesses to the USB-specific part,
> to cope with it being different on different platfroms, like AM35x. The driver
> as it was last posted, just needs rework now.

are you saying you will do the work ?

> >>    Don't know, I was quite content with the abstraction when writing CPPI 4.1
> >> driver for MUSB...
> 
> > look closer. The whole:
> 
> > if (is_cppi())
> > 	foo();
> > else if (is_inventra())
> > 	bar();
> > else if (is_omap_sdma())
> > 	baz();
> 
> > is bogus.
> 
>    That part -- yes. There were attempt to get rid of this, but without changing
> the DMA API. It was left halfway done after my only critical comment, IIRC. Will
> we ever see the continuation of this effort?

patches are welcome

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/9c8464df/attachment.sig>
