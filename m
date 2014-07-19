From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 Jul 2014 09:38:33 +0200
Subject: [PATCH v3 1/3] asm-generic/io.h: Implement generic {read,
 write}s*()
In-Reply-To: <20140718210631.GA22109@ravnborg.org>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <20140718205953.GA21964@ravnborg.org> <20140718210631.GA22109@ravnborg.org>
Message-ID: <43703371.jktNRIezc3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 July 2014 23:06:31 Sam Ravnborg wrote:
> > 
> > All these things are not introduced by your patch but now that
> > you show some love and care for this file maybe we could take
> > the next step and bring more order to the current semi chaos?
> 
> And I just noticed...
> 
> These are never used - and only defined a few places:
> #define inb_p(addr)     inb(addr)
> #define inw_p(addr)     inw(addr)
> #define inl_p(addr)     inl(addr)
> #define outb_p(x, addr) outb((x), (addr))
> #define outw_p(x, addr) outw((x), (addr))
> #define outl_p(x, addr) outl((x), (addr))
> 
> Likewise for these:
> #define insb_p(port,to,len)     insb(port,to,len)
> #define insw_p(port,to,len)     insw(port,to,len)
> #define insl_p(port,to,len)     insl(port,to,len)
> 
> #define outsb_p(port,from,len)  outsb(port,from,len)
> #define outsw_p(port,from,len)  outsw(port,from,len)
> #define outsl_p(port,from,len)  outsl(port,from,len)
> 
> 
> 
> This set:
> #define inb_p(addr)     inb(addr)
> #define inw_p(addr)     inw(addr)
> #define inl_p(addr)     inl(addr)
> #define outb_p(x, addr) outb((x), (addr))
> #define outw_p(x, addr) outw((x), (addr))
> #define outl_p(x, addr) outl((x), (addr))
> 
> Should have a comment that say they are deprecated.
> Especially the "b" variants still have many users.

Are they? I don't remember ever seeing a reason to deprecate
them. We could perhaps enclose them in #ifdef CONFIG_ISA, but
there may also be some drivers that use the same code for ISA
and PCI, and it doesn't really hurt on PCI.

	Arnd
