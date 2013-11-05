From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Nov 2013 10:48:55 +0100
Subject: [PATCH v4 4/4] ARM: new platform for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <201311041456.27654.arnd@arndb.de>
References: <20131104105836.GI14892@pengutronix.de>
 <1383562853-17202-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <201311041456.27654.arnd@arndb.de>
Message-ID: <20131105094854.GL14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 02:56:27PM +0100, Arnd Bergmann wrote:
> On Monday 04 November 2013, Uwe Kleine-K?nig wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/Kconfig                 |  19 +++++++-
> >  arch/arm/Makefile                |   1 +
> >  arch/arm/configs/efm32_defconfig | 102 +++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-efm32/Makefile     |   1 +
> >  arch/arm/mach-efm32/dtmachine.c  |  15 ++++++
> >  5 files changed, 137 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/configs/efm32_defconfig
> >  create mode 100644 arch/arm/mach-efm32/Makefile
> >  create mode 100644 arch/arm/mach-efm32/dtmachine.c
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 7ae0615..d8145fe 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -413,6 +413,23 @@ config ARCH_EBSA110
> >           Ethernet interface, two PCMCIA sockets, two serial ports and a
> >           parallel port.
> >  
> > +config ARCH_EFM32
> > +       bool "Energy Micro efm32"
> > +       depends on !MMU
> > +       select ARCH_REQUIRE_GPIOLIB
> > +       select ARM_NVIC
> > +       select CLKSRC_MMIO
> > +       select CLKSRC_OF
> > +       select COMMON_CLK
> > +       select CPU_V7M
> > +       select GENERIC_CLOCKEVENTS
> > +       select NO_DMA
> > +       select NO_IOPORT
> > +       select SPARSE_IRQ
> > +       select USE_OF
> > +       help
> > +         Support for Energy Micro's (now Silicon Labs) efm32 processors.
> > +
> 
> It would be good to have at least in either the changeset description or the Kconfig
> text (or both) some description about the platform: which SoCs have been tested,
> what is this platform used for, where can one find data sheets etc.
I have links to the datasheet of the processor and the user manual of
the board in the corresponding device trees. Also I added a paragraph to
the commit log mentioning the development board I used:

	There are still some missing parts (e.g. board support, device
	trees), but with these bits added on top of this patch I can
	successfully boot a EFM32GG-DK3750 board that uses an
	EFM32GG990F1024.

Good enough?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
