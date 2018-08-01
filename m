From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 1 Aug 2018 21:57:33 +0200
Subject: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180801172747.GJ5509@sirena.org.uk>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
 <20180801172747.GJ5509@sirena.org.uk>
Message-ID: <20180801215733.4dfa3a95@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 1 Aug 2018 18:27:47 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jun 27, 2018 at 03:16:08PM +0200, Piotr Bugalski wrote:
> > Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
> > New spi-mem interface allows usage also other memory types, especially
> > much larger NAND with SPI interface. This driver works as SPI controller
> > and is not related to MTD, however can work with NAND-flash or other
> > peripherals using spi-mem interface.  
> 
> This is fine from a SPI point of view

Cool. There are still 2 things I think should be addressed before
merging the driver:
1/ Fixing the SoB tag to match the author (problem reported by
   Alexandre)
2/ Getting this patch [1] merged and implementing the ->get_name() hook
   in this driver so that SPI NOR devs declared to the MTD layer keep
   the same name after the transition to spi-mem and mtdparts= passed on
   the cmdline keep working. Without this in place we're likely to
   break a few setups :-/.

> but I'd like to apply it directly
> to the SPI tree rather than ack it for merge via the MTD tree - can we
> work something out with a shared branch or something?

Sure, I can provide an immutable tag for you to pull and I'll add my
acks on those patches once the 2 things I mentioned above are
addressed.

Regards,

Boris

[1]https://patchwork.kernel.org/patch/10508693/ 
