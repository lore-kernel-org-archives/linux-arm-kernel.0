From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 14 Feb 2012 13:28:43 -0500 (EST)
Subject: [PATCH 00/15] mach/io.h cleanup and removal
In-Reply-To: <201202141757.03748.arnd@arndb.de>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <4F39D2EE.80806@gmail.com> <20120214172423.GO1426@atomide.com>
 <201202141757.03748.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1202141325460.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Feb 2012, Arnd Bergmann wrote:

> On Tuesday 14 February 2012, Tony Lindgren wrote:
> > Yes should be just the legacy drivers needing this for most part,
> > so that's currently most of omap1 drivers for us.
> > 
> > Anyways I'm using plat/omap-iomap.h for the name, so if somebody
> > has better ideas for naming to avoid further search and replace
> > later on, let me know.
> > 
> > I guess in the long run we could have
> > 
> > #include <mach-omap1/iomap.h>
> > 
> > instead of
> > 
> > #include <plat/omap-iomap.h>
> > 
> > as the plat can't be used for multi-subarch builds.
> 
> I think it /could/ be used, we just need to make a definite
> decision which way we want to go for header files that
> are defined by a platform and used by code outside of that
> platform such as device drivers.
> 
> The two main approaches that I can see are
> 
> a) make every header file name unique for platforms that you want to
> build together, and just add every path at the compiler command line.
> Not too much work, but somewhat error prone when you start having
> file name conflicts.

The preprocessor will happily take the first file that matches in its 
search path, masking any other files with the same name.  That can 
become rather confusing.

> b) move all platform specific header files into a directory named after
> the platform and change all device drivers using this. Lots of work, but
> probably better in the long run.

I clearly favor (b).


Nicolas
