From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Jan 2013 10:15:09 -0800
Subject: [PATCH 3/3] ARM: OMAP: SRAM: resolve sparse warnings
In-Reply-To: <20121224012500.13698.73653.stgit@dusk.lan>
References: <20121224012304.13698.43551.stgit@dusk.lan>
 <20121224012500.13698.73653.stgit@dusk.lan>
Message-ID: <20130101181508.GB22106@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121223 17:30]:
> Commit bb77209432873214a796a70a4539e4ebdf3feb54 ("ARM: OMAP: Move
> omap2+ specific parts of sram.c to mach-omap2") adds some new sparse
> warnings:
> 
> arch/arm/plat-omap/sram.c:43:6: warning: symbol 'omap_sram_push_address' was not declared. Should it be static?
> arch/arm/plat-omap/sram.c:65:6: warning: symbol 'omap_sram_reset' was not declared. Should it be static?
> arch/arm/plat-omap/sram.c:73:13: warning: symbol 'omap_map_sram' was not declared. Should it be static?
> 
> Fix by creating a temporary header file containing prototypes for
> these SRAM functions - needed until the SRAM code is moved to
> drivers/.  arch/arm/plat-omap/include/plat/sram.h can't be added due
> to ARM CONFIG_ARCH_MULTIPLATFORM restrictions on the use of the "plat/"
> include path shortcut.

Here too we should just include <plat/sram.h>, that's OK for the
multiplatform builds. Just drivers will not have it available.
Then eventually the issue disappears as this code becomes a regular
device driver.

Regards,

Tony
