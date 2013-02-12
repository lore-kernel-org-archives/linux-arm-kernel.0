From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 14:54:10 +0000
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <511A0F11.1050608@stericsson.com>
References: <511A0F11.1050608@stericsson.com>
Message-ID: <201302121454.10231.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Jean-Nicolas GRAUX wrote:
> ello, Arnd, Olof. First, let me introduce myself quickly.
> I am working in Stericsson and i am a colleague of Linus Walleij.
> We are currently doing some cleaning in our mach-ux500 ARM machine.
> 
> Among other things, the U8500 SoC and its derivatives embed one small IP 
> called the "hardware observer".
> This is used for hardware debug purpose and it provides the ability to 
> output some
> modem, power, clocking, ..., hardware signals on 18 external wires.
> 
> We did one small platform device driver to handle this piece of hardware.
> In the patch attached to this file, we kept the code in the mach-ux500 
> machine folder.
> But we are wondering where is the best place to put that stuff.
> So, the question is: where should we put this code in the kernel tree ?
 
Hi Jean-Nicolas,

I think I need some more information to understand what that interface
you are driving is actually about, since that is not clear from your
description or from reading the source code.

Why are there exactly 18 wires?

What is the protocol that is used on these wires (i2c, spi, rs232, ...)

Why do you actually need run-time configuration in the kernel? 

It does look however like this code is related to the PRCMU, so maybe
it should be part of the prcmu driver rather than a separate device?

	Arnd
