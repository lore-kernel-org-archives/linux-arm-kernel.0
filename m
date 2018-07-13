From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 13 Jul 2018 12:06:33 +0200
Subject: [PATCH v10 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <dc410321-5dfd-7c26-2a3e-d2b2840da214@microchip.com>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-6-radu.pirea@microchip.com>
 <20180710181559.GG8104@sirena.org.uk>
 <dc410321-5dfd-7c26-2a3e-d2b2840da214@microchip.com>
Message-ID: <20180713100633.GR16084@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/2018 12:56:22+0300, Radu Pirea wrote:
> 
> 
> On 07/10/2018 09:15 PM, Mark Brown wrote:
> > On Mon, Jun 25, 2018 at 08:22:29PM +0300, Radu Pirea wrote:
> > 
> > This is mostly good, just a couple of small things:
> > 
> > > +config SPI_AT91_USART
> > > +	tristate "Atmel USART Controller SPI driver"
> > > +	depends on HAS_DMA
> > > +	depends on (ARCH_AT91 || COMPILE_TEST)
> > > +	select MFD_AT91_USART
> > 
> > Why is this selecting rather than depending on the MFD like we normally
> > do?
> > 
> 
> Hi Mark,
> 
> If I add depends instead of select, current defconfigs will be broken and
> the proper driver will not be selected. Like this, there is no required
> change in any defconfig. Selecting the serial or spi driver from menuconfig
> makes the MFD completely transparent.

I would say that this is true for the USART part but the SPI part can
use a depends on as it didn't exist before.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
