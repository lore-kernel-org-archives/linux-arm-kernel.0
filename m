From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Dec 2012 21:52:14 +0530
Subject: [PATCH 1/3] ARM: OMAP: 32k counter: resolve sparse warnings
In-Reply-To: <20121224012456.13698.41839.stgit@dusk.lan>
References: <20121224012304.13698.43551.stgit@dusk.lan>
 <20121224012456.13698.41839.stgit@dusk.lan>
Message-ID: <50D9D2B6.4060906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 December 2012 06:54 AM, Paul Walmsley wrote:
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
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Looks good to my eyes.
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
