From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 12 Oct 2011 09:38:19 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <alpine.LFD.2.02.1110111950290.17040@xanadu.home>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111011150915.GE23188@mudshark.cambridge.arm.com>
	<20111011184821.GA11839@mudshark.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
Message-ID: <20111012083819.GB2418@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Oct 11, 2011 at 08:03:38PM -0400, Nicolas Pitre wrote:
> On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> 
> > I've stuck them into the arm-soc tree for now, so we get linux-next
> > coverage, but I won't send them to Linus this way because then we
> > would get the same commits twice in the history.
> 
> Could you please do the same with the following:
> 
>   git://git.linaro.org/people/nico/linux.git mach_memory_h
> 
> Russell pulled it at some point, and dropped it due to concerns about 
> repeated conflict resolutions (or so I presume).  I just did a test 
> merge between your for-next branch and the above and that looked trivial 
> enough.

I just had a quick look at this branch as picoxcell has just been merged 
with an empty memory.h.  I'll submit a patch to remove that, but I just 
noticed in "ARM: switch from NO_MACH_MEMORY_H to NEED_MACH_MEMORY_H" 
there is this hunk:

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e00fe76..6d49d2f1d 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -14,6 +14,7 @@ config ARCH_OMAP1
        select CLKDEV_LOOKUP
        select CLKSRC_MMIO
        select GENERIC_IRQ_CHIP
+       select HAVE_MACH_MEMORY_H
        help
          "Systems based on omap7xx, omap15xx or omap16xx"

and I think that should be "select NEED_MACH_MEMORY_H" instead.

Jamie
