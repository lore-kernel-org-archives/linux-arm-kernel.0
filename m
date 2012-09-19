From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Sep 2012 15:29:17 +0200
Subject: [PATCH 0/5] ARM: EXYNOS: Add secure firmware support
In-Reply-To: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
Message-ID: <32882618.QIYkyWltBx@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 13 of September 2012 10:13:33 Tomasz Figa wrote:
> Some Exynos-based boards are running with secure firmware running in
> TrustZone secure world, which changes the way some things have to be
> initialized.
> 
> This series adds support for specifying firmware operations, implements
> some firmware operations for Exynos secure firmware and adds a method of
> enabling secure firmware operations on Exynos-based boards through board
> file and device tree.
> 
> This is a continuation of the patch series by Kyungmin Park:
> [PATCH v5 1/2] ARM: Make a compile firmware conditionally
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/183607
> [PATCH v5 2/2] ARM: EXYNOS: SMC instruction (aka firmware) support
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/183608/focus=184109
> 
> Tomasz Figa (5):
>   ARM: EXYNOS: Add IO mapping for non-secure SYSRAM.
>   ARM: Add interface for registering and calling firmware-specific
>     operations
>   ARM: EXYNOS: Add support for secure monitor calls
>   ARM: EXYNOS: Add support for Exynos secure firmware
>   ARM: EXYNOS: Add secure firmware support to secondary CPU bring-up
> 
>  .../devicetree/bindings/arm/samsung-boards.txt     |  8 ++++
>  arch/arm/common/Makefile                           |  2 +
>  arch/arm/common/firmware.c                         | 18 ++++++++
>  arch/arm/include/asm/firmware.h                    | 30 +++++++++++++
>  arch/arm/mach-exynos/Makefile                      |  6 +++
>  arch/arm/mach-exynos/common.c                      | 34 ++++++++++++++
>  arch/arm/mach-exynos/common.h                      |  2 +
>  arch/arm/mach-exynos/exynos-smc.S                  | 22 +++++++++
>  arch/arm/mach-exynos/firmware.c                    | 52
> ++++++++++++++++++++++ arch/arm/mach-exynos/include/mach/map.h          
>  |  3 ++
>  arch/arm/mach-exynos/mach-exynos4-dt.c             |  1 +
>  arch/arm/mach-exynos/platsmp.c                     |  8 ++++
>  arch/arm/mach-exynos/smc.h                         | 31 +++++++++++++
>  arch/arm/plat-samsung/include/plat/map-s5p.h       |  1 +
>  14 files changed, 218 insertions(+)
>  create mode 100644 arch/arm/common/firmware.c
>  create mode 100644 arch/arm/include/asm/firmware.h
>  create mode 100644 arch/arm/mach-exynos/exynos-smc.S
>  create mode 100644 arch/arm/mach-exynos/firmware.c
>  create mode 100644 arch/arm/mach-exynos/smc.h

Any further comments for this series? Maybe we could merge it for 3.7?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
