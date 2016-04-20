From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 20 Apr 2016 10:46:17 +0200
Subject: [PATCH] ARM: imx25-pinfunc: remove SION from all modes
In-Reply-To: <20160419211958.GD19428@n2100.arm.linux.org.uk>
References: <1461095114-11745-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160419211958.GD19428@n2100.arm.linux.org.uk>
Message-ID: <20160420104617.15cf8461@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 19 Apr 2016 22:19:58 +0100 Russell King - ARM Linux wrote:
> On Tue, Apr 19, 2016 at 09:45:14PM +0200, Uwe Kleine-K?nig wrote:
> > With the SION bit set a pin can be read as GPIO even though it's not muxed
> > as GPIO. This is useful at times. The downside however is that the signal
> > is not only routed to the GPIO IP but also all other IPs that can make use
> > of the pin. This resulted in more than one issue for me in the past. Things
> > like spi transfers that result in usb reenumeration or setting a GPIO to a
> > value that triggers an RTS irq for an UART.
> 
> Isn't SION required for all GPIOs such that reading the value of a GPIO
> pin returns the actual state of the pin, not the output value written
> to it?
> 
> What about the ethernet pins?  I know that on iMX6, SION is required for
> correct functionality of certain phy clocking modes, and I wouldn't be
> surprised if this was true in earlier designs as well.
> 
SION essentially makes any OUTPUT pin (GPIO or other function)
bidirectional.


Lothar Wa?mann
