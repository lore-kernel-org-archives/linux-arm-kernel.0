From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Jul 2011 00:15:05 -0700
Subject: [PATCH 9/10] arch/arm/mach-omap2/clock.c: add missing clk_put
In-Reply-To: <alpine.DEB.2.00.1106021526220.26852@utopia.booyaka.com>
References: <1306948213-20767-9-git-send-email-julia@diku.dk>
	<alpine.DEB.2.00.1106021526220.26852@utopia.booyaka.com>
Message-ID: <20110701071505.GB23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110602 14:22]:
> On Wed, 1 Jun 2011, Julia Lawall wrote:
> 
> > From: Julia Lawall <julia@diku.dk>
> > 
> > Add missing call to clk_put.
> > 
> > A simplified version of the semantic match that finds this problem is as
> > follows: (http://coccinelle.lip6.fr/)
> > 
> > // <smpl>
> > @r exists@
> > expression e1,e2;
> > statement S;
> > @@
> > 
> > e1 = clk_get at p1(...);
> > ... when != e1 = e2
> >     when != clk_put(e1)
> >     when any
> > if (...) { ... when != clk_put(e1)
> >                when != if (...) { ... clk_put(e1) ... }
> > * return at p3 ...;
> >  } else S
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Adding this into devel-fixes branch.

Tony
