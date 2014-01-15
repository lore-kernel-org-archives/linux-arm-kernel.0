From: joe@perches.com (Joe Perches)
Date: Wed, 15 Jan 2014 01:21:36 -0800
Subject: [PATCH] ARM: imx: clk-imx6sl: Suppress duplicate const sparse
 warning
In-Reply-To: <20140115065851.GC1914@S2101-09.ap.freescale.net>
References: <1389766774-16661-1-git-send-email-Ying.Liu@freescale.com>
 <20140115065851.GC1914@S2101-09.ap.freescale.net>
Message-ID: <1389777696.14001.14.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-15 at 14:58 +0800, Shawn Guo wrote:
> On Wed, Jan 15, 2014 at 02:19:34PM +0800, Liu Ying wrote:
> > There should be no duplicate const specifiers for those static
> > constant character string arrays defined for clock mux options.
> > Also, the arrays are only taken as the 5th argument for the
> > imx_clk_mux() function, which is in the type of 'const char
> > **parents'.  So, let's remove the 2nd const specifier right
> > after 'char'.
> > 
> > This patch fixes these sparse warnings:
> > arch/arm/mach-imx/clk-imx6sl.c:21:25: warning: duplicate const
[]
> > diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
[]
> > @@ -18,27 +18,27 @@
> >  #include "clk.h"
> >  #include "common.h"
> >  
> > -static const char const *step_sels[]		= { "osc", "pll2_pfd2", };
> ...
> > +static const char *step_sels[]		= { "osc", "pll2_pfd2", };
> 
> So now we're getting the following checkpatch warning:
> 
> WARNING: static const char * array should probably be static const char * const
> 
> It was added into checkpatch.pl by commit cb710ec (scripts/checkpatch.pl:
> add warnings for static char that could be static const char).  I'm not
> sure which warning we should ignore, the sparse or the checkpatch one.
> 
> Joe, comments?

Maybe the const **parents argument could be const * const *

That could change a lot of declarations through.
You could also ignore checkpatch.
