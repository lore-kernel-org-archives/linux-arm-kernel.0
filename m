From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Mar 2014 20:28:32 +0100
Subject: [PATCH v6 6/6] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <CAMuHMdWzm1D83zquwuQVKwbqRdXmSw7u1ui7iZyC3VGdGhn0HA@mail.gmail.com>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com>
 <1469359.kil5iaOqdU@wuerfel>
 <CAMuHMdWzm1D83zquwuQVKwbqRdXmSw7u1ui7iZyC3VGdGhn0HA@mail.gmail.com>
Message-ID: <2669340.5Jm6AjVlSo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 March 2014 20:16:25 Geert Uytterhoeven wrote:
> On Mon, Mar 10, 2014 at 7:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> arch/avr32/include/asm/io.h:#define IO_SPACE_LIMIT    0xffffffff
> >> arch/frv/include/asm/io.h:#define IO_SPACE_LIMIT      0xffffffff
> >
> > They have no MMU, and the code relies on the port number to match
> > both the virtual and the physical address. You could be right about
> > these, but I would guess that the code also needs some other
> > changes if we want to make it work on nommu kernels. It also depends
> > on whether the I/O bus address is the same as the CPU address, or
> > if it starts at bus address 0.
> 
> >> arch/m68k/include/asm/io_no.h:#define IO_SPACE_LIMIT 0xffffffff
> >
> > This looks like a mistake, it should be smaller
> 
> io_no.h is for nommu.

Ah, I missed that. In that case I assume it doesn't matter because
the only m68k with PCI is M54xx and that always has an MMU.

	Arnd
