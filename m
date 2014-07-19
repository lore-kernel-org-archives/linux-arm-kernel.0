From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 Jul 2014 11:05:33 +0200
Subject: [PATCH v3 1/3] asm-generic/io.h: Implement generic {read,
 write}s*()
In-Reply-To: <20140719084152.GA31564@ravnborg.org>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <43703371.jktNRIezc3@wuerfel> <20140719084152.GA31564@ravnborg.org>
Message-ID: <4967546.K5Yf5hcJE1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 July 2014 10:41:52 Sam Ravnborg wrote:
> > > 
> > > This set:
> > > #define inb_p(addr)     inb(addr)
> > > #define inw_p(addr)     inw(addr)
> > > #define inl_p(addr)     inl(addr)
> > > #define outb_p(x, addr) outb((x), (addr))
> > > #define outw_p(x, addr) outw((x), (addr))
> > > #define outl_p(x, addr) outl((x), (addr))
> > > 
> > > Should have a comment that say they are deprecated.
> > > Especially the "b" variants still have many users.
> > 
> > Are they? I don't remember ever seeing a reason to deprecate
> > them. We could perhaps enclose them in #ifdef CONFIG_ISA, but
> > there may also be some drivers that use the same code for ISA
> > and PCI, and it doesn't really hurt on PCI.
> 
> It is my understanding that inl and inl_p are the same these days.
> A quick grep indicate that only m68k define the
> _p variant different from the other.
> But I failed to find and description of the difference between the
> two which is why I assumed they were identical and thus no need for both.

I don't know why m68k needs it, it's really an x86-specific
thing, see slow_down_io() in arch/x86/include/asm/io.h.

	Arnd
