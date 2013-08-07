From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Aug 2013 18:08:51 +0200
Subject: [PATCH 00/20] ARM: pxa: move core and drivers to dmaengine
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <201308071808.51400.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 August 2013, Daniel Mack wrote:
> I've been working on teaching the mmp-pdma driver more functions and
> porting tree-wide scattered pxa specific drivers over to dmaengine
> implementations. I posted the first round of patches for mmp-pdma here:
> 
>   http://marc.info/?l=linux-arm-kernel&m=137587082530228
> 
> 
> With the following patches applied, I can boot a PXA3xx board boot with
> all DMA runtime information determined from DT, using pxa3xx-nand,
> pxamci and audio components (cyclic DMA).
> 
> However, the transition is quite intrusive and spans across several
> subsystem, and due to the nature of the current pxa DMA implementation,
> it cannot be gap-less. All drivers currently request an exclusive
> channel via code in arch/arm/plat-pxa/dma.c and then do direct register
> modifications regarding their obtained channel. We can't allow this
> with the mmp-pdma driver of course, and I also have no idea how to
> provide sane stubs for the existing hooks which end up in dmaengine
> calls.
> 
> Hence, all drivers have to be ported over in one series, and all these
> changes should be merged by one pull request eventually in order to
> prevent both build and functional breakage. Haojian's repository seems
> most suitable for that, as he's the PXA maintainer.

Very nice series! I just looked over these and only found a few minor details
that could be improved.

	Arnd
