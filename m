From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Jan 2013 10:13:20 -0800
Subject: [PATCH 1/3] ARM: OMAP: 32k counter: resolve sparse warnings
In-Reply-To: <20121224012456.13698.41839.stgit@dusk.lan>
References: <20121224012304.13698.43551.stgit@dusk.lan>
 <20121224012456.13698.41839.stgit@dusk.lan>
Message-ID: <20130101181319.GA22106@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the delay, just noticed this looking at your pull request.

* Paul Walmsley <paul@pwsan.com> [121223 17:30]:
> Commit 1fe97c8f6a1de67a5f56e029a818903d5bed8017 ("ARM: OMAP: Make OMAP
> clocksource source selection using kernel param") results in a new warning
> from sparse:
> 
> arch/arm/plat-omap/counter_32k.c:86:12: warning: symbol 'omap_init_clocksource_32k' was not declared. Should it be static?
> 
> Fix by adding a temporary header file, needed until the 32k counter
> code is moved to drivers/.
> arch/arm/plat-omap/include/plat/counter-32k.h can't be added due to
> ARM CONFIG_ARCH_MULTIPLATFORM restrictions on the use of the "plat/"
> include path shortcut.

Here it's OK to include <plat/counter-32k.h> for multiplatform builds
as the path will be included in plat-omap/Makefile.

So include <plat/*.h> will only disappear for drivers. In the long
run we should just make the remaining code in plat-omap into drivers,
and then issue will disappear for good. But until these are all drivers,
we should just include <plat/counter-32k.h>.

Regards,

Tony
