From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 04 May 2011 10:04:04 -0500
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <BANLkTiminpyJ_opxhqG0E0gBOrF490b+tQ@mail.gmail.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
	<BANLkTiminpyJ_opxhqG0E0gBOrF490b+tQ@mail.gmail.com>
Message-ID: <1304521444.2810.23.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-04 at 00:44 -0400, Mike Frysinger wrote:
> On Tue, May 3, 2011 at 17:30, Sven Eckelmann wrote:
> > Introduce an *_dec_not_zero operation.  Make this a special case of
> > *_add_unless because batman-adv uses atomic_dec_not_zero in different
> > places like re-broadcast queue or aggregation queue management. There
> > are other non-final patches which may also want to use this macro.
> >
> > Cc: uclinux-dist-devel at blackfin.uclinux.org
> >
> > --- a/arch/blackfin/include/asm/atomic.h
> > +++ b/arch/blackfin/include/asm/atomic.h
> > @@ -103,6 +103,7 @@ static inline int atomic_test_mask(int mask, atomic_t *v)
> >        c != (u);                                               \
> >  })
> >  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> > +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
> >
> >  /*
> >  * atomic_inc_and_test - increment and test
> 
> no opinion on the actual idea, but for the Blackfin pieces:
> Acked-by: Mike Frysinger <vapier@gentoo.org>

This goes for parisc as well.

Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>

James
