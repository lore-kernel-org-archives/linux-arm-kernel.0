From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Sep 2014 21:56:10 +0200
Subject: pxa-dt and multiple platforms support
In-Reply-To: <8738bcdf2r.fsf@free.fr>
References: <877g0pc5g6.fsf@free.fr> <32462021.GYIKv5x9AF@wuerfel>
 <8738bcdf2r.fsf@free.fr>
Message-ID: <2605016.XXNIkQVRuo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 September 2014 21:43:40 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > I think it should be easy enough to move the function declarations you need out of
> > mach/pxa3xx.h and mach/pxa27x.h into a file that is shared between the platforms,
> > and that is included by both. The DT file won't need the register definitions
> > or a lot of the other things that are provided by mach/pxa3xx.h.
> 
> Yes, I had thought of that, and generic.h would be a good candidate.
> 
> I have not mentioned it because there is one thing I'm afraid of : should we
> discover that any pxa variant initialization requires one register to be
> accessed, then the pxa-dt should be split into several pxaXXX-dt.c anyway.
> 
> It is not the case AFAIK. I'm pondering the risk against having 2 split apart
> files ...

The register definitions are total crap and you shouldn't use them for the
DT file anyway. If you get to the point where you have to touch some
registers, I think the right answer would be to have a DT node for the
register block and use of_iomap with a platform specific offset, or
a proper device driver.

It's more likely that you won't actually need this though.

	Arnd
