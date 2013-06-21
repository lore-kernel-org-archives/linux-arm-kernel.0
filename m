From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 09:36:43 +0200
Subject: [GIT PULL 08/10] Samsung SoC EXYNOS5420 for v3.11
In-Reply-To: <25bc01ce6e09$b149fc20$13ddf460$%kim@samsung.com>
References: <51C0BC74.1060502@samsung.com> <201306202258.26968.arnd@arndb.de>
 <25bc01ce6e09$b149fc20$13ddf460$%kim@samsung.com>
Message-ID: <201306210936.43780.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Kukjin Kim wrote:
> > I'll probably have to create a next/soc2 branch, but
> > will first try to merge the Renesas pull requests, which may have
> > similar problems.
> > 
> > If it's possible to rebase this one not to have any dependencies
> > other than the branches merged into next/cleanup and next/soc,
> > I can pull it more easily, as long as I can figure out how
> > to merge it with the common-clk-audio branch.
> > 
> I see, BTW as you can see, the common-clk-audio touches all of samsung dt
> files to use '#include' instead of '/include/' so I couldn't remove the
> dependencies :( sorry about that.
> 
> If anything is required, please kindly let me know.

No, we'll figure it out.

I think a better solution would have been to do the change do the
dts files in a separate "cleanup" branch and have everything else
that touches those files build on that branch. That way you could
have maintained the flat hierarchy.

I'll just merge it as a 'late' branch for now.

	Arnd
