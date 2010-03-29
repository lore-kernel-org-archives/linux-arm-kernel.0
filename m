From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 29 Mar 2010 11:01:37 +0100
Subject: request_irq in I2C driver causes kernel to freeze during
	probe, but if done later - no problem!
In-Reply-To: <20100327011223.GG31126@trinity.fluff.org>
References: <4BAD406A.7070208@atmel.com>
	<20100326232421.GG29179@n2100.arm.linux.org.uk>
	<4BAD4FDE.2010904@atmel.com> <4BAD5450.7020605@atmel.com>
	<20100327011223.GG31126@trinity.fluff.org>
Message-ID: <20100329100136.GB13239@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 27, 2010 at 01:12:23AM +0000, Ben Dooks wrote:
> On Sat, Mar 27, 2010 at 01:41:52AM +0100, Ulf Samuelsson wrote:

> > I tried doing an I2C transfer inside the interrupt routine
> > (this is my only way of logging)
> > and then the I2C probe routine locked up already when
> > doing the request_irq.

> i2c transfers can sleep, thus you need somet thread or work-queue to
> process them. 

Or with current (post 2.6.29, IIRC 2.6.33 or later) kernels use a
threaded IRQ handler for the I2C interactions.
