From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 10 May 2012 13:18:00 +0200
Subject: [PATCHv2 0/3] Add support for DRM display subsystem
In-Reply-To: <037301cd2e90$529112e0$f7b338a0$%kim@samsung.com>
References: <1331635180-7207-1-git-send-email-m.szyprowski@samsung.com>
 <037301cd2e90$529112e0$f7b338a0$%kim@samsung.com>
Message-ID: <01fb01cd2e9e$8f4cfbf0$ade6f3d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, May 10, 2012 11:36 AM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > Hello,
> >
> > This patch set adds support for Exynos DRM display subsystem for
> > Universal C210 and NURI boards. Exynos DRM driver has been merged to 3.3
> > kernel tree and provides unified and more powerful alternative for
> > s3c-fb and s5p-tv drivers. V2 includes update for the latest changes in
> > platform data structure (added 'panel' entry).
> >
> > Best regards
> >
> > Marek Szyprowski
> > Samsung Poland R&D Center
> >
> > Patch summary:
> >
> > Marek Szyprowski (3):
> >   ARM: Exynos: add platform device for core DRM subsystem
> >   ARM: Exynos: Add DRM core device support for Universal C210 board
> >   ARM: Exynos: Add DRM core support for NURI board
> >
> >  arch/arm/mach-exynos/Kconfig               |    7 ++++++
> >  arch/arm/mach-exynos/Makefile              |    1 +
> >  arch/arm/mach-exynos/dev-drm.c             |   29
> ++++++++++++++++++++++++
> >  arch/arm/mach-exynos/mach-nuri.c           |   33
> > ++++++++++++++++++++++++++++
> >  arch/arm/mach-exynos/mach-universal_c210.c |   33
> > ++++++++++++++++++++++++++++
> >  arch/arm/plat-samsung/include/plat/devs.h  |    2 +
> >  6 files changed, 105 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-exynos/dev-drm.c
> >
> > --
> > 1.7.1.569.g6f426
> 
> Well, 2nd and 3rd patches can break multi-platform for EXYNOS SoCs with one
> kernel image.

We can switch completely to DRM driver for both boards and remove entries for 
s3c-fb/tv if this is really needed. IMHO it is a bit lame that the DRM driver
is already in the mainline, but none of the boards use it. Even if one wants
to add support for it to his own board, he cannot find any reference code for
it...

> And I won't apply new feature for non-dt board file from now on. I think, we
> need to support DT in mach-exynos/ instead of non-DT and DT together, so
> please consider to move on dt supporting for Samsung mobile boards.
> 
> Note that I have a plan to replace board files with DT supporting in
> mach-exynos/ next time.

Right now the DT support is so incomplete that even basic things like gpio 
interrupts are not yet supported. This will be a huge regression if you remove
the existing board files and replace them with DT stubs.
 
Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
