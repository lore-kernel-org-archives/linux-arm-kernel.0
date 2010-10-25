From: alex@gai.ru (Alexander Sverdlin)
Date: Tue, 26 Oct 2010 02:37:58 +0400
Subject: cmpxchg() in recent kernels
In-Reply-To: <20101025210712.GC879@boggieman.bredbandsbolaget.se>
References: <4CB036B7.7000100@gai.ru>
	<AANLkTi=PeHQRibtU=jv69KVNWovtNsG3S11M0BLCnbRC@mail.gmail.com>
	<20101024214338.GB878@boggieman.bredbandsbolaget.se>
	<20101024220846.GA6041@n2100.arm.linux.org.uk>
	<AANLkTi=sRPzP+SJRpWY4QXtikVFqVVX3tizX5f+17e=B@mail.gmail.com>
	<20101025210712.GC879@boggieman.bredbandsbolaget.se>
Message-ID: <1288046278.2098.10.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 2010-10-25 at 23:07 +0200, Kristoffer Ericson wrote:
> On Mon, Oct 25, 2010 at 12:33:49PM +1100, Aras Vaichas wrote:
> > On 25 October 2010 09:08, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > >
> > > On Sun, Oct 24, 2010 at 11:43:38PM +0200, Kristoffer Ericson wrote:
> > > > Im seeing something similiar, using GCC 3.4.5
> > > > ARM HP Jornada 720, 2.6.36
> > snip ...
> > > > kernel/built-in.o(.text+0x1d038): In function `alloc_pid':
> > > > include/asm-generic/cmpxchg-local.h:42: undefined reference to `wrong_size_cmpxchg'
> > > > make: *** [.tmp_vmlinux1] Error 1
> > >
> > > Probably needs to be bisected, but I think in the long run we'll have
> > > to accept that gcc 4 will become the minimum compiler version.
> > 
> > I just tested a build with GCC 4.2.3 and it linked correctly. The only
> > problem is that the kernel image size is now 3x as big.
> > 
> 
> Im using a GCC 4.2.2 here and Im not seeing those issues, size
> is pretty much exactly the same. Just FYI.
> 

Since I've switched from gcc 3.4.3 to gcc 4.4.1, problem with cmpxchg()
disappeared. And yes, size for my config is pretty much the same as
before, about 1.2-1.4mb.

Alexander.
