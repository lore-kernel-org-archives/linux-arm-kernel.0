From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 15:06:48 +0100
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160219125959.GA8675@yury-N73SV>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <208897488.c0hkBy2G1S@wuerfel> <20160219125959.GA8675@yury-N73SV>
Message-ID: <91909204.T63Mn1YGy7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 15:59:59 Yury Norov wrote:
> On Fri, Feb 19, 2016 at 09:23:35AM +0100, Arnd Bergmann wrote:
> > On Friday 19 February 2016 01:35:06 Yury Norov wrote:

> > In https://github.com/norov/glibc/commit/5d4290435e428267171ece871539b76e1d079d11
> > you are defining a struct __kernel_stat64 in the glibc. Is this the expected
> > way to do it? I would have thought you'd get the definition from the kernel
> > headers.
> >  
> > 	Arnd
> > 
> 
> Almost all ports define its own struct kernel_stat / kernel_stat64.
> in "kernel_header.h" See mips, spark, alpha, i386... Some also define
> function xstat_conv or similar. With all that defined, it's expected
> that one of generic xstat wrappers will work properly. I tried all,
> and noone got working, so I wrote this hack to make it work somehow. 

I see. I grepped for __kernel_stat64 and couldn't find any other
with that name, as the others tend to us slightly different names.

I would still think there is something wrong if you need to define
your own copy of xstat_conv when the kernel 'struct stat64' is
meant to be usable by user space. Shouldn't this work like any
other 32-bit architecture now?

	Arnd
