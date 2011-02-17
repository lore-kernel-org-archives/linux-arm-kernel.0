From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Feb 2011 15:41:11 +0100
Subject: [PATCH V3 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <71326bcb-7836-4820-84c1-f3d8257e9f92@VA3EHSMHS020.ehs.local>
References: <1297872716-13353-1-git-send-email-john.linn@xilinx.com>
	<20110217100126.GD22961@pulham.picochip.com>
	<71326bcb-7836-4820-84c1-f3d8257e9f92@VA3EHSMHS020.ehs.local>
Message-ID: <201102171541.12261.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 February 2011, John Linn wrote:
> > > +
> > > +#define UART_FIFO_WRITE(base, value) \
> > > +   (*(volatile unsigned int *)((base) + UART_FIFO_OFFSET) =
> (value))
> > > +
> > > +#define UART_STATUS(base) \
> > > +   (*(volatile unsigned int *)((base) + UART_SR_OFFSET))
> > 
> > You could probably make these static inline functions in the header
> and
> > use __raw_{readl,writel}() to make this a little cleaner.
> > 
> 
> I had considered that, but it wasn't clear to me at the time what the
> compressor could use or not.
> 
> I'll give it a try as I agree that's cleaner.

Actually, for correctness you should use the regular readl/writel, not
the __raw_ versions, which can result in reordered or partial accesses
on the bus.

	Arnd
