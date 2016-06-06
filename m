From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jun 2016 14:25:29 +0200
Subject: [GIT PULL 4/8] ARM: exynos: Topic branch with driver changes for v4.8
In-Reply-To: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465215933-22709-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A topic branch for MultiFormat Codec driver. This pulls in
an external dependency from media tree (Sylwester Nawrocki).

Below you will find two pull-request-changelogs


Best regards,
Krzysztof


################################################################
Samsung tree only changes:
################################################################

The following changes since commit 04f776734c4e03e33111d3d5a994b589870df623:

  media: s5p-mfc: add iommu support (2016-06-03 11:13:45 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-exynos-mfc-4.8

for you to fetch changes up to 96167bd37dd604cbba0aed341765dda8556405b2:

  ARM: dts: exynos: Enable MFC device on Exynos4412 Odroid boards (2016-06-06 09:30:43 +0200)

----------------------------------------------------------------
Topic branch for Exynos MFC changes for v4.8:
Pull s5p-mfc changes from media tree so the arm/mach-exynos code
could be removed. The bindings are converted to generic reserved memory
bindings.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      Merge branch 'for-v4.8/media/exynos-mfc' of git://linuxtv.org/snawrocki/samsung into for-v4.8/exynos-mfc

Marek Szyprowski (3):
      ARM: EXYNOS: Remove code for MFC custom reserved memory handling
      ARM: dts: exynos: Convert MFC device to generic reserved memory bindings
      ARM: dts: exynos: Enable MFC device on Exynos4412 Odroid boards

 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi  | 29 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210-origen.dts            |  4 ++--
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  4 ++--
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  6 ++++++
 arch/arm/boot/dts/exynos4412-origen.dts            |  4 ++--
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  4 ++--
 arch/arm/boot/dts/exynos5250-arndale.dts           |  4 ++--
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  4 ++--
 arch/arm/boot/dts/exynos5250-spring.dts            |  4 ++--
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  4 ++--
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  4 ++--
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  4 ++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  4 ++--
 arch/arm/mach-exynos/Makefile                      |  2 --
 arch/arm/mach-exynos/exynos.c                      | 19 -------------------
 arch/arm/mach-exynos/mfc.h                         | 16 ----------------
 arch/arm/mach-exynos/s5p-dev-mfc.c                 | 93 ---------------------------------------------------------------------------------------------
 18 files changed, 59 insertions(+), 154 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
 delete mode 100644 arch/arm/mach-exynos/mfc.h
 delete mode 100644 arch/arm/mach-exynos/s5p-dev-mfc.c


################################################################
Full changes (including dependency):
################################################################

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-exynos-mfc-4.8

for you to fetch changes up to 96167bd37dd604cbba0aed341765dda8556405b2:

  ARM: dts: exynos: Enable MFC device on Exynos4412 Odroid boards (2016-06-06 09:30:43 +0200)

----------------------------------------------------------------
Topic branch for Exynos MFC changes for v4.8:
Pull s5p-mfc changes from media tree so the arm/mach-exynos code
could be removed. The bindings are converted to generic reserved memory
bindings.

----------------------------------------------------------------
Javier Martinez Canillas (3):
      s5p-mfc: Set device name for reserved memory region devs
      s5p-mfc: Add release callback for memory region devs
      s5p-mfc: Fix race between s5p_mfc_probe() and s5p_mfc_open()

Krzysztof Kozlowski (1):
      Merge branch 'for-v4.8/media/exynos-mfc' of git://linuxtv.org/snawrocki/samsung into for-v4.8/exynos-mfc

Marek Szyprowski (9):
      media: vb2-dma-contig: add helper for setting dma max seg size
      media: set proper max seg size for devices on Exynos SoCs
      of: reserved_mem: add support for using more than one region for given device
      media: s5p-mfc: use generic reserved memory bindings
      media: s5p-mfc: replace custom reserved memory handling code with generic one
      media: s5p-mfc: add iommu support
      ARM: EXYNOS: Remove code for MFC custom reserved memory handling
      ARM: dts: exynos: Convert MFC device to generic reserved memory bindings
      ARM: dts: exynos: Enable MFC device on Exynos4412 Odroid boards

 .../devicetree/bindings/media/s5p-mfc.txt          |  39 +++-
 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi  |  29 +++
 arch/arm/boot/dts/exynos4210-origen.dts            |   4 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |   4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   6 +
 arch/arm/boot/dts/exynos4412-origen.dts            |   4 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |   4 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   4 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   4 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |   4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   4 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   4 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   4 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   4 +-
 arch/arm/mach-exynos/Makefile                      |   2 -
 arch/arm/mach-exynos/exynos.c                      |  19 --
 arch/arm/mach-exynos/mfc.h                         |  16 --
 arch/arm/mach-exynos/s5p-dev-mfc.c                 |  93 ----------
 drivers/media/platform/exynos-gsc/gsc-core.c       |   2 +
 drivers/media/platform/exynos4-is/fimc-core.c      |   2 +
 drivers/media/platform/exynos4-is/fimc-is.c        |   2 +
 drivers/media/platform/exynos4-is/fimc-lite.c      |   2 +
 drivers/media/platform/s5p-g2d/g2d.c               |   2 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c        |   2 +
 drivers/media/platform/s5p-mfc/s5p_mfc.c           | 198 ++++++++++++---------
 drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h     |  79 ++++++++
 drivers/media/platform/s5p-tv/mixer_video.c        |   2 +
 drivers/media/v4l2-core/videobuf2-dma-contig.c     |  53 ++++++
 drivers/of/of_reserved_mem.c                       |  85 ++++++---
 include/linux/of_reserved_mem.h                    |  25 ++-
 include/media/videobuf2-dma-contig.h               |   2 +
 32 files changed, 438 insertions(+), 270 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
 delete mode 100644 arch/arm/mach-exynos/mfc.h
 delete mode 100644 arch/arm/mach-exynos/s5p-dev-mfc.c
 create mode 100644 drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h
