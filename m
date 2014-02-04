From: joe@perches.com (Joe Perches)
Date: Tue, 04 Feb 2014 11:43:46 -0800
Subject: [ath9k-devel] [PATCH 1/3] ath9k: Fix build error on ARM
In-Reply-To: <3469296.SINb5BZOG8@wuerfel>
References: <1391483274-20331-1-git-send-email-sujith@msujith.org>
 <CAOpc7mFQZ3efZda0cC28BLATqRDJ99BRNu=ezQq8wa+dyFyOvA@mail.gmail.com>
 <1391531796.2538.21.camel@joe-AO722> <3469296.SINb5BZOG8@wuerfel>
Message-ID: <1391543026.2538.28.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-04 at 19:40 +0100, Arnd Bergmann wrote:
> On Tuesday 04 February 2014 08:36:36 Joe Perches wrote:
> > On Tue, 2014-02-04 at 08:03 +0100, Holger Schurig wrote:
> > > Joe, look in linux/arch/arm/include/asm/delay.h. The macro udelay
> > > cannot handle large values because of lost-of-precision.
> > > 
> > > IMHO udelay on ARM is broken, because it also cannot work with fast
> > > ARM processors (where bogomips >= 3355, which is in sight now). It's
> > > just not broken enought that someone did something against it ...   so
> > > the current kludge is good enought.
> > 
> > Maybe something like this would be better?
> > 
> 
> I actually like the fact that we get link errors for insane 'udelay'
> times.

For static values yes, for computed values no.

This emits a warning/dump_stack on the non-static
values.  It could also emit some similar #warning
on static values > insane too.
