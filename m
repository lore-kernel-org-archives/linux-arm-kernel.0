From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 28 Nov 2012 16:44:20 +0100
Subject: [PATCH v4 0/5] ARM: EXYNOS: Add secure firmware support
In-Reply-To: <122d01cdc9ea$5a0d6550$0e282ff0$%kim@samsung.com>
References: <1353599478-24617-1-git-send-email-t.figa@samsung.com>
 <122d01cdc9ea$5a0d6550$0e282ff0$%kim@samsung.com>
Message-ID: <3839370.Os5KVhzhEZ@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 24 of November 2012 11:21:03 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > Some Exynos-based boards are running with secure firmware running in
> > TrustZone secure world, which changes the way some things have to be
> > initialized.
> > 
> > This series adds support for specifying firmware operations,
> > implements
> > some firmware operations for Exynos secure firmware and adds a method
> > of enabling secure firmware operations on Exynos-based boards through
> > board file and device tree.
> > 
> > Depends on:
> >   - ARM: EXYNOS: Add support for secondary CPU bring-up on Exynos4412
> > 
> > Changes since v3
> > ( http://thread.gmane.org/gmane.linux.kernel.samsung-soc/13442 )
> > 
> >   - Replaced cpu_boot_reg call with cpu_set_boot_addr
> >   - Added interface documentation
> >   - Separated from Exynos4x12 secondary CPU bring-up patch
> > 
> > Changes since v2
> > ( http://thread.gmane.org/gmane.linux.kernel.samsung-soc/12848 )
> > 
> >   - Made Exynos firmware binding require address
> >   - Minor style fixes
> > 
> > Changes since v1
> > ( http://thread.gmane.org/gmane.linux.kernel.samsung-
> > soc/12583/focus=12820 )
> > 
> >   - Changed return types of all operations to int
> >   - Defined all operations to return 0 on success, -ENOSYS when not
> >   
> >     implemented or appropriate error code on error
> > 
> > Tomasz Figa (5):
> >   ARM: Add interface for registering and calling firmware-specific
> >   
> >     operations
> >   
> >   ARM: EXYNOS: Add support for secure monitor calls
> >   ARM: EXYNOS: Add support for Exynos secure firmware
> >   ARM: EXYNOS: Add IO mapping for non-secure SYSRAM.
> >   ARM: EXYNOS: Add secure firmware support to secondary CPU bring-up
> >  
> >  Documentation/arm/firmware.txt                     | 88
> >  ++++++++++++++++++++++
> >  .../devicetree/bindings/arm/samsung-boards.txt     | 10 +++
> >  arch/arm/common/Makefile                           |  2 +
> >  arch/arm/common/firmware.c                         | 18 +++++
> >  arch/arm/include/asm/firmware.h                    | 66
> >  ++++++++++++++++ arch/arm/mach-exynos/Makefile                     
> >  |  6 ++
> >  arch/arm/mach-exynos/common.c                      | 35 +++++++++
> >  arch/arm/mach-exynos/common.h                      |  2 +
> >  arch/arm/mach-exynos/exynos-smc.S                  | 22 ++++++
> >  arch/arm/mach-exynos/firmware.c                    | 70
> >  +++++++++++++++++ arch/arm/mach-exynos/include/mach/map.h           
> >  |  3 +
> >  arch/arm/mach-exynos/mach-exynos4-dt.c             |  1 +
> >  arch/arm/mach-exynos/platsmp.c                     | 32 ++++++--
> >  arch/arm/mach-exynos/smc.h                         | 31 ++++++++
> >  arch/arm/plat-samsung/include/plat/map-s5p.h       |  1 +
> >  15 files changed, 382 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/arm/firmware.txt
> >  create mode 100644 arch/arm/common/firmware.c
> >  create mode 100644 arch/arm/include/asm/firmware.h
> >  create mode 100644 arch/arm/mach-exynos/exynos-smc.S
> >  create mode 100644 arch/arm/mach-exynos/firmware.c
> >  create mode 100644 arch/arm/mach-exynos/smc.h
> > 
> > --
> > 1.8.0
> 
> Russell, I think, Tomasz addressed comments from you.
> 
> If you're ok on this, please ack so that I can pick this up in my tree
> for v3.8...

Arnd, Olof, what do you think?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
