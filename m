From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 15:23:47 +0100
Subject: [PATCH 9/9] ARM: vexpress: Config option for early printk console
In-Reply-To: <1342016181.30755.2.camel@hornet>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-10-git-send-email-pawel.moll@arm.com>
 <20120711140912.GC13498@mudshark.cambridge.arm.com>
 <1342016181.30755.2.camel@hornet>
Message-ID: <1342016627.30755.5.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-11 at 15:16 +0100, Pawel Moll wrote:
> On Wed, 2012-07-11 at 15:09 +0100, Will Deacon wrote:
> > > +#else /* CONFIG_DEBUG_LL_UART_NONE */
> > > +
> > > +		.macro	addruart, rp, rv, tmp
> > > +		/*
> > > +		 * Have to provide reasonable dummy values,
> > > +		 * otherwise code in head.S crashes badly...
> > > +		 */
> > > +		mov	\rp, #0
> > > +		mov	\rv, #0
> > > +		.endm
> > 
> > Eek, this means we take out an I/O section mapping at zero, doesn't it?
> > Is that really a good idea? It scares me because (a) it's below PAGE_OFFSET
> > and (b) we don't know consistently what's at physical address 0.
> > 
> > Perhaps we could change head.S to avoid the mapping if addruart returns a
> > NULL virtual address?
> 
> Sure (care to prepare a patch? ;-), but this will have to go through
> Russell not arm-soc, so it won't be a part of this update. And I'll
> remove the comment...

... and use DEBUG_LL_VIRT_BASE as the \rv for now, before the change in
head.S happen. Physical 0 on VE is always flash, so it's not a problem.

Pawel
