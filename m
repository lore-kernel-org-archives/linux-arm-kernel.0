From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:19:34 +0900
Subject: [GIT PULL 08/10] secure-exynos for v3.10
Message-ID: <51630A36.6030505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit da821eb7d42935b0f7056d98c75fd1150f6636f4:

   Merge commit 'v3.9-rc5' into next/clk-exynos (2013-04-09 01:10:13 +0900)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/secure-exynos-for-v3.10

for you to fetch changes up to beddf63fc8e01f06799bd6d7a2dd879885bbc9c6:

   ARM: EXYNOS: Add secure firmware support to secondary CPU bring-up 
(2013-04-09 01:52:30 +0900)

----------------------------------------------------------------
add support secure firmware for exynos

----------------------------------------------------------------
Tomasz Figa (5):
       ARM: Add interface for registering and calling firmware-specific 
operations
       ARM: EXYNOS: Add support for secure monitor calls
       ARM: EXYNOS: Add support for Exynos secure firmware
       ARM: EXYNOS: Add IO mapping for non-secure SYSRAM.
       ARM: EXYNOS: Add secure firmware support to secondary CPU bring-up

  Documentation/arm/firmware.txt                     | 88 
++++++++++++++++++++++
  .../devicetree/bindings/arm/samsung-boards.txt     | 10 +++
  arch/arm/common/Makefile                           |  2 +
  arch/arm/common/firmware.c                         | 18 +++++
  arch/arm/include/asm/firmware.h                    | 66 ++++++++++++++++
  arch/arm/mach-exynos/Makefile                      |  6 ++
  arch/arm/mach-exynos/common.c                      | 35 +++++++++
  arch/arm/mach-exynos/common.h                      |  2 +
  arch/arm/mach-exynos/exynos-smc.S                  | 22 ++++++
  arch/arm/mach-exynos/firmware.c                    | 70 +++++++++++++++++
  arch/arm/mach-exynos/include/mach/map.h            |  3 +
  arch/arm/mach-exynos/mach-exynos4-dt.c             |  1 +
  arch/arm/mach-exynos/platsmp.c                     | 32 ++++++--
  arch/arm/mach-exynos/smc.h                         | 31 ++++++++
  arch/arm/plat-samsung/include/plat/map-s5p.h       |  1 +
  15 files changed, 382 insertions(+), 5 deletions(-)
  create mode 100644 Documentation/arm/firmware.txt
  create mode 100644 arch/arm/common/firmware.c
  create mode 100644 arch/arm/include/asm/firmware.h
  create mode 100644 arch/arm/mach-exynos/exynos-smc.S
  create mode 100644 arch/arm/mach-exynos/firmware.c
  create mode 100644 arch/arm/mach-exynos/smc.h

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
