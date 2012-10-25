From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2012 13:30:09 +0000
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <50893389.2090002@gmail.com>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
Message-ID: <201210251330.09456.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012, Rob Herring wrote:
> > On Thu, Oct 11, 2012 at 07:43:22AM -0500, Rob Herring wrote:
> >>
> >> With recent compilers and move to generic unaligned.h in commit d25c881
> >> (ARM: 7493/1: use generic unaligned.h), unaligned accesses will be used
> >> by the LZO decompressor on v7 cores. So we need to make sure unaligned
> >> accesses are allowed by clearing the SCTLR A bit.
> > 
> > I just read this in http://gcc.gnu.org/gcc-4.7/changes.html:
> > 
> >   On ARM, when compiling for ARMv6 (but not ARMv6-M), ARMv7-A, ARMv7-R, or
> >   ARMv7-M, the new option -munaligned-access is active by default, which for
> >   some source codes generates code that accesses memory on unaligned addresses.
> >   This will require the kernel of those systems to enable such accesses
> >   (controlled by CP15 register c1, refer to ARM documentation). Alternatively
> >   or for compatibility with kernels where unaligned accesses are not supported,
> >   all code has to be compiled with -mno-unaligned-access. Linux/ARM in official
> >   releases has automatically and unconditionally supported unaligned accesses
> >   as emitted by GCC due to this option being active, since Linux version 2.6.28.
> 
> I don't think there is such a thing as ARMv6-M.

There is, that would be the Cortex-M0/M0+/M1. You cannot run Linux on these.

	Arnd
