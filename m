From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jun 2012 18:34:41 +0000
Subject: RF231 transceiver on at91sam9g20ek board
In-Reply-To: <CAJmB2rDxv45OP4otn7rmQcpzCvLujKm0j9_OqNW6PoyHuarTLw@mail.gmail.com>
References: <CAJmB2rDxv45OP4otn7rmQcpzCvLujKm0j9_OqNW6PoyHuarTLw@mail.gmail.com>
Message-ID: <201206221834.41869.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 June 2012, Alexander Smirnov wrote:
> I'm the developer of the IEEE 802.15.4 kernel branch, and currently
> I've faced with the problem regarding mach-at91 arch and hope you can
> advise me.
> 
> I've been working with at86rf231 transceiver (RF231 extender)
> connected via SPI to at91sam9g20ek board. The driver works and tested
> for kernels up to 3.1 version (versions 3.2-latest haven't ever been
> tested yet).
> Several days ago I've ported the IEEE802.15.4 stack to the latest
> kernel and see some strange things: RF231 interrupt handler is
> permanently pulled right after driver's probe method (the RF231 chip
> is in disabled mode, so it can't generate interrupts at that moment).
> Also I've noticed that each ENTER key pressing in minicom generates a
> new interrupt. It looks like somebody else uses the same pin/pins for
> its needs...
> 
> Do you have any ideas what can be changed since 3.1 kernel that this
> problem arose.
> 

It might not be the problem you are faced with but note that at91
is moving towards probing all devices using the device tree, so
starting with linux-3.4 you should be defining the device in the
at91sam9g20ek.dts file for your board and use the generic
board-dt.c file. The platform_data gets replaced with
calls to of_get_gpio() in that case.

	Arnd
