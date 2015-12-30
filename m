From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Dec 2015 11:35:01 +0100
Subject: [PATCH 2/4] soc: mediatek: Init MT8173 scpsys driver earlier
In-Reply-To: <1451470328.22426.5.camel@mtksdaap41>
References: <1451457706-14798-1-git-send-email-jamesjj.liao@mediatek.com>
 <1670989.QknqqsXE3p@wuerfel> <1451470328.22426.5.camel@mtksdaap41>
Message-ID: <6145950.8rtkDup7QD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 December 2015 18:12:08 James Liao wrote:
> On Wed, 2015-12-30 at 09:52 +0100, Arnd Bergmann wrote:
> > On Wednesday 30 December 2015 14:41:44 James Liao wrote:
> > > Some power domain comsumers may init before module_init.
> > > So the power domain provider (scpsys) need to be initialized
> > > earlier too.
> > > 
> > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > > ---
> > > 
> > 
> > Why?
> 
> Some drivers use different init level to ensure they can be initialized
> before other drivers. To support these drivers, moving scpsys driver's
> initial function to subsys_init is the most easy way.

This is just the same generic explanation that you already have.

Please be more specific what the dependency is and why we can't rely
on deferred probing here.

	Arnd
