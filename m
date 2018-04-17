From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Apr 2018 10:31:35 -0700
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
 <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
Message-ID: <20180417173134.GD5671@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [180417 09:21]:
> On Monday 16 April 2018 09:15 PM, Tony Lindgren wrote:
> > Also, I'm seeing an issue where the UARTs won't idle on init
> > with 8250_omap driver if connected to the wl12xx bluetooth port
> > unless I write some data to the port first. It does not seem
> > to be related to the rts/cts lines being wired as I've tested
> > muxing them out of the way.
> 
> If this instance of UART is using DMA then it might be due an errata
> worked around in AM33/AM43/DRA7:
> https://patchwork.kernel.org/patch/6784331/

It sure sounds similar but UART_ERRATA_CLOCK_DISABLE does not
seem to help with the reset. Also disabling DMA does not seem
to help. So far the only way to clear it seems to be to write
a character (TX) on the device. Then things work just fine
even without UART_ERRATA_CLOCK_DISABLE set. I'll try to debug
this more at some point.

Regards,

Tony
