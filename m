From: max@stro.at (maximilian attems)
Date: Tue, 17 May 2011 20:44:47 +0000
Subject: [PATCH] [klibc] arm: use bx on thumb2 v3
In-Reply-To: <20110517181033.GC27656@arm.com>
References: <1305649031-15622-1-git-send-email-max@stro.at>
	<20110517181033.GC27656@arm.com>
Message-ID: <20110517204447.GL17786@vostochny.stro.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 07:10:33PM +0100, Dave Martin wrote:
> On Tue, May 17, 2011 at 06:17:10PM +0200, maximilian attems wrote:
> > --- a/usr/include/arch/arm/klibc/asmmacros.h
> > +++ b/usr/include/arch/arm/klibc/asmmacros.h
> > @@ -27,4 +27,10 @@
> >  	 (((x) & ~0xf000000f) == 0) || \
> >  	 (((x) & ~0xc000003f) == 0))
> >  
> > +#if _KLIBC_ARM_USE_BX
> > +# define BX(x) bx	##x
> > +#else
> > +# define BX(x) mov	pc, ##x
> > +#endif
> > +
> 
> What's the ## for?  The C preprocessor collapses whitespace around this
> operator, so won't this expand to strings like "bxlr" in the _KLIBC_ARM_USE_BX
> case?

good catch, had tested the mov pc, x case on the debian parter box.
will just remove them on the merged patch.
 
> Otherwise this looks OK, though I'm not a klibc expert.

thanks for review.

-- 
maks
