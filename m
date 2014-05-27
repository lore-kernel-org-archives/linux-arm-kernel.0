From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 28 May 2014 01:20:00 +0200
Subject: PXA 2xx devictree port and clock infrastructure
In-Reply-To: <4580668.Rz95HmpxUr@wuerfel> (Arnd Bergmann's message of "Tue, 27
 May 2014 17:49:46 +0200")
References: <87zji3cr3d.fsf@free.fr> <201405271717.48783.arnd@arndb.de>
 <20140527154303.GA6835@leverpostej> <4580668.Rz95HmpxUr@wuerfel>
Message-ID: <87vbsqdd27.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Right, that is the general recommendation at least. I'm always a bit cautious
> when it comes to PXA because I don't expect that platform to fully get
> converted to DT in the long run, and very little new work is going on there.
>
> OTOH, if people like Robert and Daniel do this for fun, it's definitely
> great to see the full solution.

OK, so let's suppose I go for (c), and :
 - create drivers/clk/clk-pxa2xx.c
   => OF clock driver
 - amend the mach-pxa accordingly to move all clock stuff to this driver

Is there a clean way for the transition phase, where devicetree pxa-dt machine
will have to exist with non-DT machine code ? ie. is there around a clock driver
I can look at where both OF *and* non-OF are working ?

Ah, and given that PXA clocks are very simple :
 - their rate is almost always constant, and not changeable
 - only one register exists to enable/disable all the clocks (bitmask of 32
 possible clock enables)

Isn't there already a skeleton to handle this type of clocks ? It looks to me
pretty generic, yet I haven't found it in drivers/clk. Maybe I missed something
?

Cheers.

--
Robert
