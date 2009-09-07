From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Sep 2009 17:43:30 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <4AA52D14.4020406@googlemail.com>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1251548848.5030.11.camel@pc1117.cambridge.arm.com>
	<1251707405.7930.7.camel@pc1117.cambridge.arm.com>
	<1252337372.23780.73.camel@pc1117.cambridge.arm.com>
	<4AA52D14.4020406@googlemail.com>
Message-ID: <1252341810.23780.85.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-07 at 17:56 +0200, Dirk Behme wrote:
> Catalin Marinas wrote:
> > There is a glibc patch to allow fully position-independent code and
> > avoid CoW for text pages:
> > 
> > http://sourceware.org/ml/libc-ports/2008-10/msg00009.html
> > 
> > We tested it and it seems to solve the problem without requiring a
> > kernel patch.
> 
> Regarding "fix the tool chain/libc and not the kernel":
> 
> The initial issue we are discussing here was found with a user space 
> application downloaded as binary. Namely Ubuntu-ARM. While we could 
> try to fix some tool chains, we never will be able to fix all tool 
> chains out there. There will be ever some binaries compiled with a 
> non-patched tool chain, resulting in ARM11 MPCore failures.

Please don't get me wrong, I'm in favour of a kernel fix even though
future toolchains may avoid this problem. I'm just trying clarify the
issue and get another opinion from Russell or others on this list.

> Additionally, this Ubuntu ARM port runs fine on single core ARM11 
> (e.g. N800) or Cortex A8 (e.g OMAP3 based BeagleBoard). It's my 
> understanding that the issue we are discussing here is ARM11 MPCore 
> kernel (cache handling?) specific, then. 

It's a problem with write-allocate caches, it isn't related to SMP. When
CONFIG_SMP is enabled, the kernel sets the cache policy to writealloc.

-- 
Catalin
