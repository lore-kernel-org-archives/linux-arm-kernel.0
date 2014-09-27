From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 27 Sep 2014 21:43:40 +0200
Subject: pxa-dt and multiple platforms support
In-Reply-To: <32462021.GYIKv5x9AF@wuerfel> (Arnd Bergmann's message of "Sat,
 27 Sep 2014 21:29:24 +0200")
References: <877g0pc5g6.fsf@free.fr> <5426FD33.8080404@zonque.org>
 <32462021.GYIKv5x9AF@wuerfel>
Message-ID: <8738bcdf2r.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> I think it should be easy enough to move the function declarations you need out of
> mach/pxa3xx.h and mach/pxa27x.h into a file that is shared between the platforms,
> and that is included by both. The DT file won't need the register definitions
> or a lot of the other things that are provided by mach/pxa3xx.h.

Yes, I had thought of that, and generic.h would be a good candidate.

I have not mentioned it because there is one thing I'm afraid of : should we
discover that any pxa variant initialization requires one register to be
accessed, then the pxa-dt should be split into several pxaXXX-dt.c anyway.

It is not the case AFAIK. I'm pondering the risk against having 2 split apart
files ...

-- 
Robert
