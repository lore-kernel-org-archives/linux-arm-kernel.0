From: joe@perches.com (Joe Perches)
Date: Tue, 10 Mar 2015 13:28:58 -0700
Subject: [PATCH] mtd: clean up whitespace in linux/mtd/map.h
In-Reply-To: <20150310195832.GD4124@norris-Latitude-E6410>
References: <2266200.3mx7btcFe5@wuerfel> <2220416.D2kDyFWh1C@wuerfel>
 <1426012416.18060.22.camel@perches.com>
 <20150310195832.GD4124@norris-Latitude-E6410>
Message-ID: <1426019338.18060.34.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-03-10 at 12:58 -0700, Brian Norris wrote:
> On Tue, Mar 10, 2015 at 11:33:36AM -0700, Joe Perches wrote:
> > On Tue, 2015-03-10 at 17:51 +0100, Arnd Bergmann wrote:
> > > As the only comments I got for the "mtd: cfi: reduce stack size"
> > > patch were about whitespace changes, it appears necessary to fix
> > > up the rest of the file as well, which contains the exact same
> > > mistakes.
> > 
> > trivia:
> > 
> > > diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
> > []
> > > @@ -77,7 +77,7 @@
> > >  /* ensure we never evaluate anything shorted than an unsigned long
> > >   * to zero, and ensure we'll never miss the end of an comparison (bjd) */
> > >  
> > > -#define map_calc_words(map) ((map_bankwidth(map) + (sizeof(unsigned long)-1))/ sizeof(unsigned long))
> > > +#define map_calc_words(map) ((map_bankwidth(map) + (sizeof(unsigned long)-1)) / sizeof(unsigned long))
> > 
> > DIV_ROUND_UP?
> >  
> > >  #ifdef CONFIG_MTD_MAP_BANK_WIDTH_8
> > >  # ifdef map_bankwidth
> > > @@ -181,7 +181,7 @@ static inline int map_bankwidth_supported(int w)
> > >  	}
> > >  }
> > >  
> > > -#define MAX_MAP_LONGS ( ((MAX_MAP_BANKWIDTH*8) + BITS_PER_LONG - 1) / BITS_PER_LONG )
> > > +#define MAX_MAP_LONGS (((MAX_MAP_BANKWIDTH * 8) + BITS_PER_LONG - 1) / BITS_PER_LONG)
> > 
> > BITS_TO_LONGS?
> 
> It seems the $subject patch is really not that necessary,

Coding style patches rarely are.

> as it was just
> inspired by similarly trivial comments. But I thought CodingStyle
> was supposed to mostly be a guide for new code, not a charter to "fix
> up" old code like drivers/mtd/{chips,maps}.

'tisn't but consistency has its own virtue.

> So I would have been happy with ignoring the whitespace comments on the
> v1 stack usage patch (esp. since it *did* match the existing style), and
> avoiding the ensuing comments about helper macros. IMO, it's pretty
> silly when a simple patch to fix a real issue turns into an extended
> search for other trivial issues.
> 
> I'll probably take both of Arnd's patches as they stand,

No worries.   The comments weren't meant to derail
the original patches.

>  but any more
> trivial requests to stable code like this should come in the form of
> real patches, not respins of Arnd's patch.

I'm not respinning the patches.
If Arnd wants to do more work, that's up to him.
