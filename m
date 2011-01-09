From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 9 Jan 2011 08:14:59 +0100
Subject: suspicious code in linux/arch/arm/common/sa1111.c
In-Reply-To: <AANLkTin6QAr7=7-59aKzunh6nQGhCKPJ11OspBtC4NHB@mail.gmail.com>
References: <20101116090705.GA29337@pma.sysgo.com>
	<AANLkTin6QAr7=7-59aKzunh6nQGhCKPJ11OspBtC4NHB@mail.gmail.com>
Message-ID: <20110109071459.GA1488@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2010-11-16 17:09:59, Eric Miao wrote:
> On Tue, Nov 16, 2010 at 5:07 PM, Pavel Machek <pma@sysgo.com> wrote:
> > Hi!
> >
> > Is this good idea?
> >
> > Signed-off-by: Pavel Machek <pma@sysgo.com>
> 
> Yep, obviously was a typo.

Can you apply the patch? Or should I re--generate one with better changelog?

> > diff -ur linux.ofic//arch/arm/common/sa1111.c linux/arch/arm/common/sa1111.c
> > --- linux.ofic//arch/arm/common/sa1111.c ? ? ? ?2010-10-17 20:31:13.000000000 +0200
> > +++ linux/arch/arm/common/sa1111.c ? ? ?2010-11-05 10:44:17.000000000 +0100
> > @@ -282,7 +312,7 @@
> > ? ? ? ?for (i = 0; i < 8; i++) {
> > ? ? ? ? ? ? ? ?sa1111_writel(ip0 ^ mask, mapbase + SA1111_INTPOL0);
> > ? ? ? ? ? ? ? ?sa1111_writel(ip0, mapbase + SA1111_INTPOL0);
> > - ? ? ? ? ? ? ? if (sa1111_readl(mapbase + SA1111_INTSTATCLR1) & mask)
> > + ? ? ? ? ? ? ? if (sa1111_readl(mapbase + SA1111_INTSTATCLR0) & mask)
> > ? ? ? ? ? ? ? ? ? ? ? ?break;
> > ? ? ? ?}
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
