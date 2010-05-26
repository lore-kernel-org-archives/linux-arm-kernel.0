From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 27 May 2010 01:52:46 +0200
Subject: Controlling Driver Load Order
In-Reply-To: <AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
	<AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
Message-ID: <20100526235246.GA31068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 11:04:01PM +0200, Linus Walleij wrote:
> 2010/5/26 Robert Emanuele <rob@emanuele.us>:
> 
> > On my at91sam9g45 platform I need my i2c drivers to load before the
> > framebuffer driver. ?The i2c drivers control a power management IC
> > which is needed to enable the graphics controller.
> >
> > Is there a way to set up that order?
> 
> The usual trick (which you can find in a lot of other I2C busses) is to use
> a core_initcall() instead of module_init().

Correct, but it's subsys_initcall().

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100527/7c89b860/attachment.sig>
