From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jun 2016 13:37:30 +0200
Subject: Extcon build failure in next
In-Reply-To: <20160630054112.GN28140@atomide.com>
References: <20160630053705.GM28140@atomide.com>
 <20160630054112.GN28140@atomide.com>
Message-ID: <3746939.q8kt0ym6m3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 29, 2016 10:41:13 PM CEST Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160629 22:41]:
> > Hi Chanwoo,
> > 
> > Looks like current Linux next fails to build with at least
> > omap2plus_defconfig because of:
> > 
> > ERROR: "extcon_dev_allocate" [drivers/extcon/devres.ko] undefined!
> > scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> > make[1]: *** [__modpost] Error 1
> > Makefile:1163: recipe for target 'modules' failed
> > make: *** [modules] Error 2
> > Kernel build failed
> > 
> > Probably extcon_dev_allocate just needs EXPORT_SYMBOL_GPL?

I've sent "extcon: link devres into core module" for this

> Also I'm seeing:
> 
> drivers/extcon/extcon.c: In function 'extcon_register_notifier':
> drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (idx >= 0) {
>          ^

I don't see this one. Which compiler version do you use?

	Arnd
