From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 16:43:24 +0100
Subject: [PATCH 60/62] ARM: shmobile: work around CONFIG_PHYLIB=m
In-Reply-To: <20140320035501.GE10601@verge.net.au>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-61-git-send-email-arnd@arndb.de>
 <20140320035501.GE10601@verge.net.au>
Message-ID: <201403211643.24533.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Simon Horman wrote:
> On Wed, Mar 19, 2014 at 08:29:57PM +0100, Arnd Bergmann wrote:
> > When phylib is set to be built as a module, the lager and koelsch
> > boards fail to build:
> > 
> > arch/arm/mach-shmobile/built-in.o: In function `lager_ksz8041_fixup':
> > :(.text+0x738): undefined reference to `mdiobus_read'
> > :(.text+0x73c): undefined reference to `mdiobus_write'
> > arch/arm/mach-shmobile/built-in.o: In function `koelsch_ksz8041_fixup':
> > :(.text+0x7e8): undefined reference to `mdiobus_read'
> > :(.text+0x7ec): undefined reference to `mdiobus_write'
> > 
> > To work around that problem, this changes the code to check for
> > IS_BUILTIN rather than IS_ENABLED, turning the error into a runtime
> > problem. It's now possible to build random configurations, but the
> > phy may be set up incorrectly in this case.
> 
> I wonder if Kconfig for koelsch should be tightened up somehow to
> ensure that PHYLIB is either unselected or builtin.
> 
> Also, a minor nit, I would prefer changes for different boards
> in different patches. But I can split the patch myself if its
> not going to be changed otherwise.

I would prefer to take the entire series directly into arm-soc
this time, if you don't mind.

	Arnd
