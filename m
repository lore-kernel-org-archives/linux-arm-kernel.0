From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Nov 2012 17:45:48 -0800
Subject: Final call for 3.8 arm-soc patches
In-Reply-To: <201211162111.34615.arnd@arndb.de>
References: <201211162111.34615.arnd@arndb.de>
Message-ID: <20121117014547.GR6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [121116 13:17]:
> Hi ARM subarch maintainers,
> 
> We are currently at linux-3.7-rc5, which means the merge window is coming
> closer. We already have 759 changesets in arm-soc and I know of a few ones
> coming (tegra, clps711x, bcm), but I don't know what the status for some
> of the bigger ones (exynos/s5p/s3c, mvebu/orion, pxa/mmp). If you have
> more patches coming, please send all remaining pull requests soon, or
> let us know what is holding you up. I hope this way we can avoid having
> to reject pull requests that come too late in the cycle.

Thanks for the status update, this helps the subarch maintainers too
to stop piling up patches so at least I would like to see it every
merge cycle.

For omaps, we're pretty much done except for the following multiplatform
related changes that I'd like to get out of the way:

1. Move omap iommu/iovmm code to drivers, this is a series of six
   patches still waiting for an ack from Joerg.

2. Get rid of #include <plat/omap-serial.h>, need to coordinate with
   Russell's omap-serial.c changes that are now in linux next. This
   should be a trivial patch after Russell's changes, just need to
   update my patch to move it to include/linux/platform_data.

3. Move dma-omap.h out of the way for multiplatform. The options here
   are to add a nasty hack to arch/arm/Makefile to include plat again
   for omaps, or just move it to the already existing new header
   we have in include/linux/omap-dma.h. I'm thinking the second option
   makes more sense until the custom DMA functions are removed.

So that's about eight patches left to before mach-omap2 is multiplatform
clean. These patches don't cause any functional changes and I should
have those ready to pull by Wednesday next week if that's not too late.

Regards,

Tony 
