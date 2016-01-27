From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2016 18:09:45 +0000
Subject: Speeding up dma_unmap
In-Reply-To: <20160127160630.GQ14823@e104818-lin.cambridge.arm.com>
References: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
 <3526786.axKPs51069@wuerfel>
 <20160127160630.GQ14823@e104818-lin.cambridge.arm.com>
Message-ID: <20160127180944.GZ10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 04:06:30PM +0000, Catalin Marinas wrote:
> On Wed, Jan 27, 2016 at 01:23:27PM +0100, Arnd Bergmann wrote:
> > up reading cache lines back in randomly on a speculative prefetch,
> > but as far as I can tell, the Cortex-A8 (or A5/A7) won't do that.
> 
> Are you sure about A5 and A7? I'm not even sure about the A8 but there
> are good chances that A7 and A5 do speculative prefetches.

I thought when I was re-implementing the DMA API on ARM (which was
around early v7 times) that there were CPUs that did speculative
prefetching, which included the A8.  I seem to remember it was pretty
urgent to have the DMA API fixed for _any_ ARMv7 CPU because of the
speculative prefetching.


-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
