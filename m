From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 13 Nov 2010 10:30:01 -0500 (EST)
Subject: Single binary kernel for all i.MX
In-Reply-To: <20101112185057.GK18358@pengutronix.de>
References: <20101105121800.GV6017@pengutronix.de>
	<AANLkTim7znztJgGvZ5ZsV=ei=_W4YpjU3-5zWonrQ9ME@mail.gmail.com>
	<20101112155342.GJ18358@pengutronix.de>
	<AANLkTim0eNvEhiy7YL7YMCsJ9Ou_byyZ7hwSdy2ocsyF@mail.gmail.com>
	<20101112185057.GK18358@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1011131029100.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Nov 2010, Uwe Kleine-K?nig wrote:

> Hi Anand,
> 
> On Fri, Nov 12, 2010 at 10:59:33PM +0530, Gadiyar, Anand wrote:
> > 2010/11/12 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > > Hi Shawn,
> > >
> > > On Fri, Nov 12, 2010 at 11:40:41PM +0800, Shawn Guo wrote:
> > >> I'm studying at the implementation. ?Can you please help me understand
> > >> how "addruart" in plat-mxc/include/mach/debug-macro.S works for single
> > >> image?
> > >>
> > >> ? ? ? ? .macro ?addruart, rp, rv
> > >> ? ? ? ? ldr ? ? \rp, =UART_PADDR ? ? ? ?@ physical
> > >> ? ? ? ? ldr ? ? \rv, =UART_VADDR ? ? ? ?@ virtual
> > >> ? ? ? ? .endm
> > >>
> > >> We have this macro to get physical base address of UART. ?However
> > >> UART_PADDR is defined as MX?_UART1_BASE_ADDR depending on
> > >> CONFIG_ARCH_MX*. ?When all CONFIG_ARCH_MX* get defined in single image
> > >> case, how does UART_PADDR work for all CONFIG_ARCH_MX*?
> > > In a kernel that supports more than one SoC, DEBUG_LL won't work. ?This
> > > is generally OK, because DEBUG_LL is only needed when bringing up a
> > > machine. ?Therefor you can use a tailored kernel that only supports your
> > > shiny new machine.
> > >
> > > Uwe
> > >
> > 
> > Hi Uwe,
> > 
> > OMAP does have this working. For example, we can boot a single kernel image
> > on OMAP2, OMAP3 and OMAP4 today, and we have DEBUG_LL working for
> > sure on the last two - probably also on OMAP2.
> > 
> > I'm not exactly sure how this mechanism works, but for every new machine we
> > add, we usually add an entry in arch/arm/plat-omap/include/plat/uncompress.h
> You're mixing things up, mach/uncompress.h is for the Uncompressing
> Linux message when booting a zImage, mach/debug-macro.S is for DEBUG_LL
> and used to get debug messages out of the serial interface (usually).
> 
> The former will work for a multi-soc-imx-image, the latter probably not.

... and my previous comment applies to the later.


Nicolas
