From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 7 Nov 2010 12:34:29 +0100
Subject: Single binary kernel for all i.MX
In-Reply-To: <AANLkTikKemXjQYZ9axTP-60bu9xjGrmPE9imf+EDB-p_@mail.gmail.com>
References: <20101105121800.GV6017@pengutronix.de>
	<20101105122946.GH13530@tarshish>
	<20101105123144.GW6017@pengutronix.de>
	<AANLkTikKemXjQYZ9axTP-60bu9xjGrmPE9imf+EDB-p_@mail.gmail.com>
Message-ID: <20101107113429.GA6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Sat, Nov 06, 2010 at 02:59:02AM +0800, Eric Miao wrote:
> On Fri, Nov 5, 2010 at 8:31 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Fri, Nov 05, 2010 at 02:29:46PM +0200, Baruch Siach wrote:
> >> Hi Sascha,
> >>
> >> On Fri, Nov 05, 2010 at 01:18:00PM +0100, Sascha Hauer wrote:
> >> > We are talking about a single kernel for longer now, here is something
> >> > to test for the ones interested:
> >> >
> >> > git://git.pengutronix.de/git/imx/linux-2.6.git imx-single-kernel
> >> >
> >> > Compiling the imx_defconfig will result in a kernel which works
> >> > i.MX21, i.MX27, i.MX31, i.MX35 and i.MX51 (not tested on i.MX21).
> >> > i.MX1 does not work mainly because the kernel build will use some ARMv5
> >> > and later instructions.
> >>
> >> What is blocking i.MX25 from being included?
> >
> > It is. I just forgot to mention.
> 
> Hrm... the imx series is placing all header files in
> arch/arm/plat-mxc/include/plat
> instead of within each mach-*. Most other sub-arch doesn't behave like that at
> this moment and getting them built together ain't easy.

Indeed I had to move back one header file under mach-imx/include/mach
back to plat-mxc/include/mach.

> 
> BTW, did you get it tested on different boards, I'd be interested to see what
> could be the potential issues at run-time.

I only booted up a root nfs on different boards and was happy that it
worked so far. I have no experience with kernels supporting v5/v6/v7 in
a single binary. Has anybody tried this before? At least the defconfigs
don't show an example for this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
