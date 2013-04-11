From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 16:47:17 +0200
Subject: [PATCH 20/30] ASoC: samsung: convert to dmaengine API
In-Reply-To: <20130411142706.GB24971@opensource.wolfsonmicro.com>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-21-git-send-email-arnd@arndb.de>
 <20130411142706.GB24971@opensource.wolfsonmicro.com>
Message-ID: <201304111647.17796.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 April 2013, Mark Brown wrote:
> 
> On Thu, Apr 11, 2013 at 02:05:02AM +0200, Arnd Bergmann wrote:
> > In order to build the exynos kernel with CONFIG_ARCH_MULTIPLATFORM,
> > we must convert all users of the Samsung private DMA interface to
> > the generic dmaengine API. This version of the patch adds the
> > generic dmaengine API as an alternative to the existing samsung
> > specific one. Once all the older platforms provide support for
> > the common dmaengine interfaces, we can remove the old code.
> 
> There's generic ASoC dmaengine code which should be used instead of open
> coding this.  Lars-Peter Clausen and Lee Jones have been working on
> making this a totally generic driver, right now it's a library.

Ok, I see. I'll drop this patch from my series then and will let someone
else handle this driver in 3.11. We can probably live without sound support
in 3.10 when running a multiplatform kernel, and it will keep working
for exynos-only kernels without the patch.

Can you have a look at the other three ASoC patches in the series? I think
it would still be useful to merge them.

	Arnd
