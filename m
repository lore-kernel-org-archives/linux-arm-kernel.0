From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 13:00:24 -0700
Subject: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA14183@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
 <20120503155717.GE5140@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA14183@DBDE01.ent.ti.com>
Message-ID: <20120504200024.GT5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120503 23:31]:
> On Thu, May 03, 2012 at 21:27:18, Tony Lindgren wrote:
> > Hi,
> > 
> > * Hiremath, Vaibhav <hvaibhav@ti.com> [120502 02:37]:
> > > On Wed, May 02, 2012 at 14:53:24, Paul Walmsley wrote:
> > > > Hi
> > > > 
> > > > On Fri, 2 Dec 2011, hvaibhav at ti.com wrote:
> > > > 
> > > > > From: Afzal Mohammed <afzal@ti.com>
> > > > > 
> > > > > This patch adds minimal support for AM335X EVM.
> > > > > The approach taken here is to add AM335X EVM support
> > > > > to AM3517EVM, considering the fact that with device tree
> > > > > developement we will get rid of board-*.c.
> > > > > 
> > > > > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > > > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > > > 
> > > > I realize people may not necessarily like this, but I think that the 
> > > > AM33xx EVM needs its own board file.  This is because it really has 
> > > > nothing to do with the AM3517EVM.  Also, the AM3517EVM depends on 
> > > > CONFIG_ARCH_OMAP3, but the AM33xx EVM should not: it should depend on 
> > > > either CONFIG_ARCH_OMAPAM33XX, or CONFIG_ARCH_OMAP4.
> > 
> > I guess adding CONFIG_SOC_AM33XX makes sense if it does not share anything
> > except core with omap3. And the SOC is independent of the core selected,
> > there is no dependency between SoC and the core.
> > 
> > Note that we have CONFIG_ARCH_OMAP2PLUS, all the other ones should be just
> > CONFIG_SOC_XXX. As all omap3 omap4 and am33xx are v7, there's no need to
> > compile with different flags either.
> >  
> 
> But still we do have ARCH_OMAP2, ARCH_OMAP3 and ARCH_OMAP4? And that's where, 
> we have issues for adding new devices like AM33xx and TI81xx.

Those will be going away, but doing it has not been done because of the amount
of churn it creates. But if we add #define CONFIG_ARCH_OMAP3 CONFIG_SOC_OMAP3
we can do it piecemeal along with other cleanups.

Tony
