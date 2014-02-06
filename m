From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 6 Feb 2014 15:38:04 +0000
Subject: [RFC/RFT 1/2] ARM: mm: introduce arch hooks for dma address
 translation routines
In-Reply-To: <52F284F3.3080601@ti.com>
References: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
 <201402041715.54538.arnd@arndb.de> <52F11788.4030500@ti.com>
 <3284212.inOfNqnVqs@wuerfel>
 <20140205162325.GB2248@e103592.cambridge.arm.com>
 <52F284F3.3080601@ti.com>
Message-ID: <20140206153804.GB2358@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 06:37:39PM +0000, Santosh Shilimkar wrote:
> Dave,
> 
> On Wednesday 05 February 2014 11:23 AM, Dave Martin wrote:

[...]

> > Santosh, bearing these arguments in mind, do you think that dma-ranges
> > is natural for your hardware?
> > 
> > The answer may be "yes", but if we're having to twist things to fit,
> > by having to describe something fake or unreal in DT and/or writing board
> > specific code to work around it, that motivates coming up with a better
> > way of describing the hardware in these cases.
> >
> The answer at least not fully "yes" with the limited look at dma-ranges
> so far.
> - The of_translate_dma_address() can be used to translate addresses
> from DMA to CPU address space. And this should work but it will be
> expensive compared to classic macro's.
> - We don't see a way for CPU -> DMA addresses translation using DT.
> Probably some more digging/pointers are is needed.

Are you saying that dma-ranges does correctly describe your hardware,
but the kernel frameworks are inadequate or suboptimal for making use of
this information?

This is a different problem from not being able to describe the hardware.

Cheers
---Dave
