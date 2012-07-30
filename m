From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Mon, 30 Jul 2012 14:15:02 +0530
Subject: [PATCH 0/3] ARM: SAMSUNG: Move FIMD headers to include/video/
Message-ID: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset moves the contents of regs-fb-v4.h and regs-fb.h from arch side
to include/video/samsung_fimd.h

This patchset is created and rebased against master branch of torvalds tree.
Tested on smdk5250 board, build tested for other boards.

Leela Krishna Amudala (3):
  Move FIMD register headers to include/video/
  arm: samsung: Include the modified FIMD header file
  driver: Include the modified FIMD header file

 arch/arm/mach-exynos/mach-nuri.c                |    2 +-
 arch/arm/mach-exynos/mach-origen.c              |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c            |    2 +-
 arch/arm/mach-exynos/mach-smdkv310.c            |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c      |    2 +-
 arch/arm/mach-exynos/setup-fimd0.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c            |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c            |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c            |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c           |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c           |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c           |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c           |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c             |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c               |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c           |    2 +-
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 -------
 arch/arm/plat-samsung/include/plat/regs-fb.h    |  403 -----------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.c        |    2 +-
 drivers/video/s3c-fb.c                          |    2 +-
 include/video/samsung_fimd.h                    |  533 +++++++++++++++++++++++
 27 files changed, 557 insertions(+), 586 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
 create mode 100644 include/video/samsung_fimd.h
