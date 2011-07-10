From: tony@atomide.com (Tony Lindgren)
Date: Sat, 9 Jul 2011 23:55:37 -0700
Subject: [GIT PULL] omap twl cleanup for v3.1 merge window
In-Reply-To: <201107081741.23425.arnd@arndb.de>
References: <20110708130102.GB5783@atomide.com>
	<201107081741.23425.arnd@arndb.de>
Message-ID: <20110710065537.GD5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [110708 08:36]:
> On Friday 08 July 2011, Tony Lindgren wrote:
> >
> >I've attached a conflict resolution patch too, it's trivial execpt
> >note that .vdac needs to be removed in board-rx51-peripherals.c.
> >
> >If this conflict causes problems for you, I can also base this series
> >on omap/board.
> 
> The conflict resolution you suggested doesn't build here:
...

> 
> These are removed in the cleanup series, but changed in the fixes branch,
> now the removal is undone

Hmm these are added in omap/board. Maybe the issue is caused by not
merging omap/board also?
 
> I tried a different path, but then got
> 
> arch/arm/mach-omap2/board-4430sdp.c:406:41: warning: 'sdp4430_vmmc_supply' defined but not used [-Wunused-variable]
> 
> Should that variable be removed or kept referenced?

That's added in omap/board. I think the resolution I posted
should work if you merge omap/cleanup omap/fixes and omap/board
into your master branch.

Or maybe I'm missing something. If you want, I can try out your
merge here too.

Regards,

Tony
