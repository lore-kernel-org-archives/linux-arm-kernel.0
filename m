From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Apr 2018 23:10:29 +0100
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <20180417173134.GD5671@atomide.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
 <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
 <20180417173134.GD5671@atomide.com>
Message-ID: <20180417221029.GL10990@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 10:31:35AM -0700, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [180417 09:21]:
> > On Monday 16 April 2018 09:15 PM, Tony Lindgren wrote:
> > > Also, I'm seeing an issue where the UARTs won't idle on init
> > > with 8250_omap driver if connected to the wl12xx bluetooth port
> > > unless I write some data to the port first. It does not seem
> > > to be related to the rts/cts lines being wired as I've tested
> > > muxing them out of the way.
> > 
> > If this instance of UART is using DMA then it might be due an errata
> > worked around in AM33/AM43/DRA7:
> > https://patchwork.kernel.org/patch/6784331/
> 
> It sure sounds similar but UART_ERRATA_CLOCK_DISABLE does not
> seem to help with the reset. Also disabling DMA does not seem
> to help. So far the only way to clear it seems to be to write
> a character (TX) on the device. Then things work just fine
> even without UART_ERRATA_CLOCK_DISABLE set. I'll try to debug
> this more at some point.

Classic case of thread hijack.  So, Tony's idle problem gets more
attention on _my_ thread than _my_ issue about TX corruption, yea,
that's fair...  Come on guys, what about my problem, which is the
subject of this thread?

I don't have CONFIG_SERIAL_8250_DMA set, so DMA can't be the issue.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
