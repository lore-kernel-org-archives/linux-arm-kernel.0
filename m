From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2016 17:38:54 +0100
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <CALT56yPDXkOvwQHngFsLkjgkyGx5HRNj8oddhFjTRdMbv5zvbw@mail.gmail.com>
References: <201603101013.04618.arnd@arndb.de>
 <CALT56yPDXkOvwQHngFsLkjgkyGx5HRNj8oddhFjTRdMbv5zvbw@mail.gmail.com>
Message-ID: <201603101738.55060.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2016, Dmitry Eremin-Solenikov wrote:
> 2016-03-10 12:13 GMT+03:00 Arnd Bergmann <arnd@arndb.de>:
> > I've found out that ARMv3 and ARMv4 is now on track to get removed from gcc in the future,
> > so I'm trying to alert everyone that I have knowledge of using ARMv4 based platforms that
> > we currenly support in the Linux kernel.
> >
> > The architecture has been declared obsolete here: https://gcc.gnu.org/gcc-6/changes.html
> > and it will be removed in the following release (gcc-7) one year later, unless someone
> > raises concerns over it.
> 
> In which form should we raise concerns? Is it about stepping up as a
> maintainers, or just
> about telling them that platforms are used? 


As I understand it, having someone step up as an active maintainer would leave the
architecture supported indefinitely, while saying you still need the support
can at least delay the process a bit. Ramana can probably clarify further
what the gcc folks are looking for exactly.

> My main concern with
> limiting ARMv4 platforms
> to older compilers would be that sooner or later we won't be able to
> use newer kernels,
> as the mainline will stop supporting older compilers.

I think we've been doing ok with keeping old compilers working, gcc-4.2 
from 2007 seems to work fine for the older targets (it misses support for
some of the armv7 platforms in turn) and in theory we should be able to
get older ones working with a few patches: according to the README
file in the kernel, we support gcc-3.2 (from 2002) in theory, but I'm
running into some trickier problems with some of the older compilers.

It's definitely clear that at some point we will stop supporting gcc-6
for building the kernel, but I don't know if that's already 2022 or
only 2038 (when all sort of software breaks).

How long do you think you need for your systems?
Do you still ship new products, or are these all legacy devices that
will have a failing battery or flash at some point in the future?

	Arnd
