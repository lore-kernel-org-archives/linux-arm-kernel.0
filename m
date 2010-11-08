From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Nov 2010 14:21:01 -0000
Subject: recent ARM Erratas 742231 & 742230 broken.
In-Reply-To: <AANLkTik3ipJHcPtsy5cTuO1PhmAbKwGfSqAE_gUKjhiG@mail.gmail.com>
References: <AANLkTim6LRZQhW6R83P0n70GdqEwFnFvb55KC8459KwY@mail.gmail.com>	<-5088739724674874052@unknownmsgid>
	<AANLkTik3ipJHcPtsy5cTuO1PhmAbKwGfSqAE_gUKjhiG@mail.gmail.com>
Message-ID: <000101cb7f50$2bc086a0$834193e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Linus,

> 2010/10/20 Will Deacon <will.deacon@arm.com>:
> 
> > The diagnostic register is only writable from secure mode so you'll need to
> > look at what these patches do (they perform simple read-modify-writes) and
> > incorporate that code into your secure software.
> > (...)
> > I doubt that your secure monitor exposes the diagnostic register through an
> > SMC interface so you'll need to change the secure boot code to enable these
> > workarounds when the system comes out of reset.
> 
> These SMC:s (System Management Call?) are getting hairier now.

Secure Monitor Call :)

What I was eluding to above is that exposing things like the diagnostic
register via an SMC is a *really* bad idea.  It's much better to set /clear
any necessary bits in the secure boot code and then be done with it.
If that's not possible, you could have a bunch of per-erratum SMCs
but if you can modify the monitor in such a way then you should be able
to modify the boot code too.
 
> Can't you add an abstraction for the stuff we need to poke into
> diagnostics registers, enabling platform-specific overrides, like
> we do for l2x0 in mm/cache-l2x0.c?

I think Russell addressed this point.

Cheers,

Will
