From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jun 2013 14:56:15 +0200
Subject: [PATCH v2] ARM: mmp: bring up pxa988 with device tree support
In-Reply-To: <CADApbeh9EJDetkvx9Sq=y58mkhU_X1oo-e_hgZqeBV9nriqTiQ@mail.gmail.com>
References: <1369969115-4279-1-git-send-email-zhangwm@marvell.com>
 <201306101035.20924.arnd@arndb.de>
 <CADApbeh9EJDetkvx9Sq=y58mkhU_X1oo-e_hgZqeBV9nriqTiQ@mail.gmail.com>
Message-ID: <2766142.mFu63TyH69@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 June 2013 17:15:33 Chao Xie wrote:
> On Mon, Jun 10, 2013 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > I guess that is a problem we have on other platforms as well, we should
> > find a generic solution for that. It would be nice to reserve a page
> > in "fixmap" and have common code map the SCU page into that.
> >
> 
> So you mean that reserve a page in arch/arm/asm/include/fixmap.h?

Yes.

> This reserve will depend on the cpu type beacuse only A9 will have SCU part.

I think A5 and ARM11MPCore as well.

> I do not know that in fixmap, the #ifdef is acceptable or not.

Yes, it is. We don't really use fixmap on ARM for anything other than
kmap_atomic at the moment. Please have a look at the powerpc and x86
implementations.

> For the common code to map the SCU page, where do you suggest to put it?

arch/arm/kernel/smp_scu.c.

	Arnd
