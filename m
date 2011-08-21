From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 09:37:44 +0100
Subject: [PATCH 00/10] Clean up some io.h and associated code
In-Reply-To: <201108181714.47464.arnd@arndb.de>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
	<201108181714.47464.arnd@arndb.de>
Message-ID: <20110821083744.GB12028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2011 at 05:14:47PM +0200, Arnd Bergmann wrote:
> On Wednesday 17 August 2011, Russell King - ARM Linux wrote:
> > This series does some cleanup of the mach/io.h header files and
> > associated definitions, including getting rid of quite a lot of
> > IO_SPACE_LIMIT definitions.
> 
> Hi Russell,
> 
> This looks very nice!
> 
> I did some research during the Cambourne meeting about of these
> and found that the omap1 and a91 platforms also need the IO_SPACE_LIMIT
> defined to 0xffffffff when CONFIG_AT91_CF or CONFIG_OMAP_CF are
> set, so these fall into the same category as CONFIG_PCMCIA_SOC_COMMON.

It looks like AT91 and OMAP both only support one socket CF, so it
probably makes sense to have them converted to use a single 64k window.
