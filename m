From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Sep 2014 21:29:24 +0200
Subject: pxa-dt and multiple platforms support
In-Reply-To: <5426FD33.8080404@zonque.org>
References: <877g0pc5g6.fsf@free.fr> <5426FD33.8080404@zonque.org>
Message-ID: <32462021.GYIKv5x9AF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 September 2014 20:08:51 Daniel Mack wrote:
> 
> On 09/27/2014 07:56 PM, Robert Jarzmik wrote:
> > When you added support for device-tree for pxa3xx, in commit "ARM: pxa3xx: add
> > generic DT machine code" (e7749a2) you wrote : "This file can be extended to
> > also support pxa2xx".
> > 
> > I was wondering is that is really possible with the current pxa status, because
> > :
> >  - you have to include mach/pxa3xx.h
> >    => this includes mach/pxa3xx-regs.h
> >    => this is specific to pxa3xx architecture
> > 
> > If I add pxa27x support into the same file, I'll have to include mach/pxa27x.h
> > (because the initialization functions are there, same reason as yours for
> > mach/pxa3xx-regs.h).
> >    => this includes mach/pxa2xx-regs.h
> >    => this is specific to pxa2xx architecture
> > 
> > Of course there will be a lot of defines conflicts, as both platforms share the
> > same register names ...
> > 
> > So did you have something specific in mind, or should I rename pxa-dt.c into
> > pxa3xx-dt.c, and create pxa27-dt.c (this last option is my current choice unless
> > a better ideas emerges) ?
> 
> I think the latter is fine for now. I certainly didn't work on pxa27x DT
> bits yet.

I think it should be easy enough to move the function declarations you need out of
mach/pxa3xx.h and mach/pxa27x.h into a file that is shared between the platforms,
and that is included by both. The DT file won't need the register definitions
or a lot of the other things that are provided by mach/pxa3xx.h.

	Arnd
