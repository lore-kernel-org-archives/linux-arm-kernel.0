From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Jun 2016 04:49:12 -0700
Subject: Extcon build failure in next
In-Reply-To: <3746939.q8kt0ym6m3@wuerfel>
References: <20160630053705.GM28140@atomide.com>
 <20160630054112.GN28140@atomide.com> <3746939.q8kt0ym6m3@wuerfel>
Message-ID: <20160630114911.GO28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [160630 04:38]:
> On Wednesday, June 29, 2016 10:41:13 PM CEST Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [160629 22:41]:
> > > Hi Chanwoo,
> > > 
> > > Looks like current Linux next fails to build with at least
> > > omap2plus_defconfig because of:
> > > 
> > > ERROR: "extcon_dev_allocate" [drivers/extcon/devres.ko] undefined!
> > > scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> > > make[1]: *** [__modpost] Error 1
> > > Makefile:1163: recipe for target 'modules' failed
> > > make: *** [modules] Error 2
> > > Kernel build failed
> > > 
> > > Probably extcon_dev_allocate just needs EXPORT_SYMBOL_GPL?
> 
> I've sent "extcon: link devres into core module" for this

OK thanks.

> > Also I'm seeing:
> > 
> > drivers/extcon/extcon.c: In function 'extcon_register_notifier':
> > drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >    if (idx >= 0) {
> >          ^
> 
> I don't see this one. Which compiler version do you use?

Looks like I'm currently using older arm-none-linux-gnueabi-gcc
(Sourcery CodeBench Lite 2014.05-29) 4.8.3 20140320 (prerelease).
I think the Debian compiler was not working few months ago and
I changed to something I had around.

Looks like the warning does not appear with arm-linux-gnueabihf-gcc
(Debian 6.1.1-3) 6.1.1 20160511.

Regards,

Tony
