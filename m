From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 25 Oct 2012 17:22:34 +0200
Subject: [PATCH v3 0/6] ARM: EXYNOS: Add secure firmware support
Message-ID: <1351178560-19188-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Exynos-based boards are running with secure firmware running in
TrustZone secure world, which changes the way some things have to be
initialized.

This series adds support for specifying firmware operations, implements
some firmware operations for Exynos secure firmware and adds a method of
enabling secure firmware operations on Exynos-based boards through board
file and device tree.

Changes since v2
( http://thread.gmane.org/gmane.linux.kernel.samsung-soc/12848 )
  - Made Exynos firmware binding require address
  - Minor style fixes

Changes since v1
( http://thread.gmane.org/gmane.linux.kernel.samsung-soc/12583/focus=12820 )
  - Changed return types of all operations to int
  - Defined all operations to return 0 on success, -ENOSYS when not
    implemented or appropriate error code on error

Tomasz Figa (6):
  ARM: Add interface for registering and calling firmware-specific
    operations
  ARM: EXYNOS: Add support for secure monitor calls
  ARM: EXYNOS: Add IO mapping for non-secure SYSRAM.
  ARM: EXYNOS: Add support for Exynos secure firmware
  ARM: EXYNOS: Add support for secondary CPU bring-up on Exynos4412
  ARM: EXYNOS: Add secure firmware support to secondary CPU bring-up

 .../devicetree/bindings/arm/samsung-boards.txt     | 10 ++++
 arch/arm/common/Makefile                           |  2 +
 arch/arm/common/firmware.c                         | 18 ++++++
 arch/arm/include/asm/firmware.h                    | 31 ++++++++++
 arch/arm/mach-exynos/Makefile                      |  6 ++
 arch/arm/mach-exynos/common.c                      | 35 +++++++++++
 arch/arm/mach-exynos/common.h                      |  2 +
 arch/arm/mach-exynos/exynos-smc.S                  | 22 +++++++
 arch/arm/mach-exynos/firmware.c                    | 67 ++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h            |  3 +
 arch/arm/mach-exynos/mach-exynos4-dt.c             |  1 +
 arch/arm/mach-exynos/platsmp.c                     | 37 ++++++++++--
 arch/arm/mach-exynos/smc.h                         | 31 ++++++++++
 arch/arm/plat-samsung/include/plat/map-s5p.h       |  1 +
 14 files changed, 260 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/common/firmware.c
 create mode 100644 arch/arm/include/asm/firmware.h
 create mode 100644 arch/arm/mach-exynos/exynos-smc.S
 create mode 100644 arch/arm/mach-exynos/firmware.c
 create mode 100644 arch/arm/mach-exynos/smc.h

-- 
1.7.12
