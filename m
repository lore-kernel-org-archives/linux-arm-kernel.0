From: sam@ravnborg.org (Sam Ravnborg)
Date: Sat, 19 Jul 2014 10:41:52 +0200
Subject: [PATCH v3 1/3] asm-generic/io.h: Implement generic
 {read,write}s*()
In-Reply-To: <43703371.jktNRIezc3@wuerfel>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <20140718205953.GA21964@ravnborg.org>
 <20140718210631.GA22109@ravnborg.org> <43703371.jktNRIezc3@wuerfel>
Message-ID: <20140719084152.GA31564@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 
> > This set:
> > #define inb_p(addr)     inb(addr)
> > #define inw_p(addr)     inw(addr)
> > #define inl_p(addr)     inl(addr)
> > #define outb_p(x, addr) outb((x), (addr))
> > #define outw_p(x, addr) outw((x), (addr))
> > #define outl_p(x, addr) outl((x), (addr))
> > 
> > Should have a comment that say they are deprecated.
> > Especially the "b" variants still have many users.
> 
> Are they? I don't remember ever seeing a reason to deprecate
> them. We could perhaps enclose them in #ifdef CONFIG_ISA, but
> there may also be some drivers that use the same code for ISA
> and PCI, and it doesn't really hurt on PCI.

It is my understanding that inl and inl_p are the same these days.
A quick grep indicate that only m68k define the
_p variant different from the other.
But I failed to find and description of the difference between the
two which is why I assumed they were identical and thus no need for both.


	Sam
