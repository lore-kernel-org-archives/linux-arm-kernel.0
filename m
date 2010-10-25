From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 25 Oct 2010 08:37:11 +0200
Subject: cmpxchg() in recent kernels
In-Reply-To: <AANLkTi=sRPzP+SJRpWY4QXtikVFqVVX3tizX5f+17e=B@mail.gmail.com>
References: <4CB036B7.7000100@gai.ru>
	<AANLkTi=PeHQRibtU=jv69KVNWovtNsG3S11M0BLCnbRC@mail.gmail.com>
	<20101024214338.GB878@boggieman.bredbandsbolaget.se>
	<20101024220846.GA6041@n2100.arm.linux.org.uk>
	<AANLkTi=sRPzP+SJRpWY4QXtikVFqVVX3tizX5f+17e=B@mail.gmail.com>
Message-ID: <20101025063711.GF8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Aras,

On Mon, Oct 25, 2010 at 12:33:49PM +1100, Aras Vaichas wrote:
> On 25 October 2010 09:08, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > On Sun, Oct 24, 2010 at 11:43:38PM +0200, Kristoffer Ericson wrote:
> > > Im seeing something similiar, using GCC 3.4.5
> > > ARM HP Jornada 720, 2.6.36
> snip ...
> > > kernel/built-in.o(.text+0x1d038): In function `alloc_pid':
> > > include/asm-generic/cmpxchg-local.h:42: undefined reference to `wrong_size_cmpxchg'
> > > make: *** [.tmp_vmlinux1] Error 1
> >
> > Probably needs to be bisected, but I think in the long run we'll have
> > to accept that gcc 4 will become the minimum compiler version.
> 
> I just tested a build with GCC 4.2.3 and it linked correctly. The only
> problem is that the kernel image size is now 3x as big.
> 
> 
> Using gcc-3.4.4-glibc-2.3.5:
> 
> * fails to link without patch to cmpxchg-local.h, but size is similar
> to my previous builds
> 
> Created:      Mon Oct 25 11:59:04 2010
> Image Type:   ARM Linux Kernel Image (gzip compressed)
> Data Size:    1471354 Bytes = 1436.87 kB = 1.40 MB
> 
> 
> Using gcc-4.2.3-glibc-2.7:
> 
> * compiles and links correctly, but size is way too big
> 
> Created:      Mon Oct 25 11:48:26 2010
> Image Type:   ARM Linux Kernel Image (gzip compressed)
> Data Size:    4576155 Bytes = 4468.90 kB = 4.36 MB
> 
> 
> Exact same code, I just changed my CROSS symbol to point to different
> GCC directories.
Can you compare the section headers of the resulting vmlinux images?
(I.e. $CROSS-objdump -h vmlinux) and report bag which section(s) got
bigger?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
