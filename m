From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 9 Jan 2015 16:42:21 +0100
Subject: at91: dt: dma usage
In-Reply-To: <2831487.RTCyiHWGfY@wuerfel>
References: <e2dd545ccf0051e1089b1a313205547c44df5c12.1413190828.git.jiri.prchal@aksignal.cz>
 <54477097.1050909@aksignal.cz> <20141217201622.GE4885@piout.net>
 <2831487.RTCyiHWGfY@wuerfel>
Message-ID: <20150109154220.GC3625@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 10:49:55PM +0100, Arnd Bergmann wrote:
> On Wednesday 17 December 2014 21:16:22 Alexandre Belloni wrote:
> > On 22/10/2014 at 10:53:43 +0200, Ji?? Prchal wrote :
> > > in fact that in at91sam chips has a lot of peripherals but only 2*8 dma channels
> > > and as my patch in last week "at91: sam9x5 dt: add usart dma definitions to dt"
> > > adds only dma definitions, not make to use them, leave it on board definition,
> > > shouldn't do the same all other peripherals definitions?
> > > I think that I2C, SPI are not as necessary as USART, but thous are always "on".
> > 
> > Not much discussion happened on that and I have the feeling this is
> > something we have to sort out. Until the dma driver are able to allocate
> > channels dynamically, it is true that this may be something we shouldn't
> > enable in the dtsi and let people activate dma in the board dts.

People can override dma-names to disable dma use for a device.

> 
> Could you use the drivers/dma/virt-dma.c infrastructure in the driver
> to do this? Are you already planning to use it?

Yes we could use virtual channels. We planned to use it for xdmac but
there is more channels so it's not a high priority. Concerning hdmac, it
will be useful due to the low number of channels but, at the moment,
it's not planned to switch to virtual channels.


Ludovic
