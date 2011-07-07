From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Jul 2011 23:59:41 -0400 (EDT)
Subject: [PATCH 07/10] ARM: mach-realview: move from ARM_DMA_ZONE_SIZE
	to mdesc->dma_zone_size
In-Reply-To: <20110706231521.GD8286@n2100.arm.linux.org.uk>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<1309919442-20451-7-git-send-email-nicolas.pitre@linaro.org>
	<20110706231521.GD8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107062340130.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Russell King - ARM Linux wrote:

> On Tue, Jul 05, 2011 at 10:30:39PM -0400, Nicolas Pitre wrote:
> > -#ifdef CONFIG_ZONE_DMA
> > -#define ARM_DMA_ZONE_SIZE	SZ_256M
> > -#endif
> ...
> > +	.dma_zone_size	= SZ_128M,
> > +	.dma_zone_size	= SZ_128M,
> > +	.dma_zone_size	= SZ_128M,
> > +	.dma_zone_size	= SZ_128M,
> > +	.dma_zone_size	= SZ_128M,
> 
> Too small...

OK, fixed.

> I think you're rushing to get these patches ready for the 3.1 merge
> window...

I'm not rushing anything.  I've been working on and off on this series 
for over a month and simply just completed it now.  Mechanical changes 
like this might sometimes have mistakes but they are usually pretty easy 
to spot by someone with a fresh look.

> Given that these patches have only just appeared, and the number of
> sillies in them, they should wait for the next merge window _unless_
> they get a thorough review and test.

I don't mind waiting for the next merge window.  It is not like this is 
going to be the last of such patch series in order to enable a single 
zImage anyway.  However the next merge window is probably going to see 
even more of those patches as a Linaro concerted effort is being 
organized to accelerate that work.  Hence I was hoping to spread the 
patch load by submitting those ones now in order to reduce the size of 
the next windo's submission.


Nicolas
