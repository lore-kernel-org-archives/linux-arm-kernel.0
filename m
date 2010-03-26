From: hjk@linutronix.de (Hans J. Koch)
Date: Fri, 26 Mar 2010 18:57:44 +0100
Subject: [PATCH 05/07] Basic IO mappings for mach-tcc8k
In-Reply-To: <63386a3d1003261028rc9c24a2pb258a823118813cf@mail.gmail.com>
References: <20100322191900.GF2040@bluebox.local>
	<20100322192748.GK2040@bluebox.local>
	<63386a3d1003230029r7ed7c4adm107298686aa14d5e@mail.gmail.com>
	<20100323101540.GB2049@bluebox.local>
	<63386a3d1003261028rc9c24a2pb258a823118813cf@mail.gmail.com>
Message-ID: <20100326175740.GA2043@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 06:28:13PM +0100, Linus Walleij wrote:
> 2010/3/23 Hans J. Koch <hjk@linutronix.de>:
> > On Tue, Mar 23, 2010 at 08:29:01AM +0100, Linus Walleij wrote:
> >> 2010/3/22 Hans J. Koch <hjk@linutronix.de>:
> >> Also check that the DTCM is really such a thing.
> >
> > Yep, I'll do this.
> 
> If you really have a system with *only* DTCM and no ITCM, I don't
> know if the TCM support in the kernel works with that right now,

It won't, AFAICT. I removed TCM from the mappings in v2. Unfortunately,
the Telechips manual doesn't say much about it, but always calls it
"DTCM" or "Data TCM". I'll try to get more information, and come up
with a patch later. It's not really important ATM.

> I've never seen a system with just ITCM or just DTCM, but if
> you can help me testing I will try to fix it up.

If I change things in arch/arm/kernel/tcm.c, I'll Cc: you anyway since
you're mentioned in the header. The code itself seems quite clear.

Thanks,
Hans

> 
> Linus
