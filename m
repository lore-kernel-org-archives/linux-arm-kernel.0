From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Wed, 23 Sep 2009 16:13:31 +0300
Subject: Thecus n2100 uart irq?
In-Reply-To: <19130.5692.953257.987602@pilspetsen.it.uu.se>
References: <19130.5692.953257.987602@pilspetsen.it.uu.se>
Message-ID: <4ABA1EFB.9050509@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Mikael Pettersson wrote:
> The other mach-iop32x machines use one of the IRQ_IOP32X_XINT[0-3]
> interrupts for their uarts. I've tried all four values on the n2100,
> but none of them seemed to work: the console would go silent when
> the kernel starts init.
> 
> Does anyone know how run the n2100 uart properly with an irq?

I found the following mention from OpenBSD installation instructions:
"On the Thecus N2100, it is necessary to move jumper J3 to J4 to properly
route the serial port interrupt to allow serial to work under OpenBSD."
And they seem to use XINT3 (not sure if looked at the right place).

Some Debian instructions recommend the opposite jumper position,
without giving any reasons.

A.
