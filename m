From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Mar 2011 15:01:38 +0100
Subject: Compiling a kernel for armv5 + armv6
In-Reply-To: <AANLkTi=u_R=c0b0PQEK_fLqEOfXe-rcyiaEr73kzo2E9@mail.gmail.com>
References: <20110303132056.GB18351@pengutronix.de>
	<AANLkTi=u_R=c0b0PQEK_fLqEOfXe-rcyiaEr73kzo2E9@mail.gmail.com>
Message-ID: <20110303140138.GP29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 03:50:26PM +0200, saeed bishara wrote:
> On Thu, Mar 3, 2011 at 3:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Doing so currently breaks with:
> >
> > arch/arm/kernel/entry-armv.S: Assembler messages:
> > arch/arm/kernel/entry-armv.S:196: Error: selected processor does not support `strex r1,r2,[sp]'
> > arch/arm/kernel/entry-armv.S:228: Error: selected processor does not support `strex r1,r2,[sp]'
> > arch/arm/kernel/entry-armv.S:286: Error: selected processor does not support `strex r1,r2,[sp]'
> > arch/arm/kernel/entry-armv.S:323: Error: selected processor does not support `strex r1,r2,[sp]'
> >
> > These are used in svc_exit and restore_user_regs.
> >
> > Is there a way to fix this or do we have to live with this?
> try to add this line to the Makefile
>  AFLAGS_entry-armv.o      :=-Wa,-march=armv6k

This surely keeps the compiler happy, but I doubt the result will work
on an armv5 processor.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
