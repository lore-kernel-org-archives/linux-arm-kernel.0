From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Apr 2012 14:14:28 +0000
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <alpine.DEB.2.00.1204091418400.23719@marmot.wormnet.eu>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <20120406234955.840F73E1323@localhost>
 <alpine.DEB.2.00.1204091418400.23719@marmot.wormnet.eu>
Message-ID: <201204091414.28918.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 April 2012, Jamie Lentin wrote:
> On Fri, 6 Apr 2012, Grant Likely wrote:
> > These two lines are dangerous.  It is not safe to 'select' Kconfig
> > symbols that have 'depends' constraints.  Otherwise, the symbol will
> > get forced on without it's dependencies.
> >
> > Typically other code handles this by creating blank "HAVE_*" symbols
> > that the needed symbol can do something like "default y if HAVE_*"
> >
> 
> Okay I didn't realise this, thanks. The options in question aren't
> hard dependencies per-se, but no serial or NAND support is probably a
> mistake, so added them here to avoid a certain amount of shooting in foot.
> 
> What's the etiquette in this situation? Adding HAVE_* seems excessive,
> would selecting them in kirkwood_defconfig make more sense? Or would it
> simply be covered by having a reasonable config on my website or suchlike?

Either way works. We don't prevent people from shooting themselves in the
foot in Kconfig, there are plenty of ways to do that already (e.g. disabling
network support on a headless system). There should be a defconfig
for each platform, so just make sure 'make kirkwood_defconfig' enables
everything you need and works on your system, it should be the
superset of all kirkwood based systems and users can disable the
stuff they don't need.

	Arnd
