From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Oct 2012 16:57:04 -0700
Subject: [GIT PULL 9/12] ARM: soc: board specific updates
In-Reply-To: <1349135827-24790-1-git-send-email-olof@lixom.net>
References: <1349135827-24790-1-git-send-email-olof@lixom.net>
Message-ID: <1349135827-24790-10-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Misc board updates:
- Greg added a handful of boards to KS8695 (since he has stepped up to
maintain it).
- Qualcomm has added DT-only board support for a couple of their newer SoCs.
- misc other updates for Samsung and Freescale boards.

Conflicts:
* add/add conflict in arch/arm/mach-shmobile/board-armadillo800eva.c. Keep both.

----------------------------------------------------------------

The following changes since commit 8b1a13b02812b60b88920801363920956691feb3:

  Merge branch 'next/drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/boards

for you to fetch changes up to e6ca4ae895e9fbf8b96d3ee1dd44ea96e95babad:

  Merge branch 'next/board-samsung' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/boards

----------------------------------------------------------------

Arnd Bergmann (1):
      Merge branch 'board' of git://github.com/hzhuang1/linux into next/boards

Fabio Estevam (1):
      ARM: mx27pdk: Add audio support

Greg Ungerer (2):
      ARM: ks8695: add board support for the SnapGear boards based on the KS8695
      ARM: ks8695: add board support for the OpenGear boards based on the KS8695

Haojian Zhuang (2):
      ARM: mmp: implement DEBUG_LL port choice
      ARM: mmp: enable debug uart port in defconfig

Kuninori Morimoto (2):
      ARM: shmobile: marzen: fixup regulator id for smsc911x
      ARM: shmobile: marzen: enable thermal sensor

Lei Wen (1):
      ARM: ttc_dkb: add nand support

Mark Brown (2):
      ARM: S3C64XX: Update configuration for WM5102 module on Cragganmore
      ARM: S3C64XX: Register audio platform devices for Bells on Cragganmore

Nobuhiro Iwamatsu (1):
      ARM: shmobile: armadillo800eva: Add support RTC

Olof Johansson (7):
      Merge branch 'ks8695/boards' into next/boards
      Merge branch 'boards' of git://git.kernel.org/.../horms/renesas into next/boards
      Merge branch 'board' of git://github.com/hzhuang1/linux into next/boards
      Merge branch 'boards' of git://git.kernel.org/.../horms/renesas into next/boards
      Merge tag 'imx-boards' of git://git.pengutronix.de/git/imx/linux-2.6 into next/boards
      Merge tag 'msm-board-for-3.7' of git://git.kernel.org/.../davidb/linux-msm into next/boards
      Merge branch 'next/board-samsung' of git://git.kernel.org/.../kgene/linux-samsung into next/boards

Phil Edworthy (1):
      ARM: shmobile: marzen: add SDHI0 support

Sachin Kamat (4):
      ARM: dts: Use active low flag for gpio-keys on Origen
      ARM: dts: Add heartbeat gpio-leds support to Origen
      ARM: EXYNOS: Add generic PWM lookup support for SMDK4X12
      ARM: EXYNOS: Add generic PWM lookup support for SMDKV310

Stephen Boyd (2):
      ARM: msm: Allow msm_iomap-8x60 and msm_iomap-8960 to coexist
      ARM: msm: Allow 8960 and 8660 to compile together

Tushar Behera (1):
      ARM: EXYNOS: Use generic pwm driver in Origen board


 arch/arm/Kconfig.debug                          |  14 ++
 arch/arm/boot/dts/exynos4210-origen.dts         |  18 +-
 arch/arm/configs/armadillo800eva_defconfig      |   3 +
 arch/arm/configs/marzen_defconfig               |   2 +
 arch/arm/configs/mmp2_defconfig                 |   5 +-
 arch/arm/configs/pxa910_defconfig               |   4 +-
 arch/arm/mach-exynos/Kconfig                    |   3 +
 arch/arm/mach-exynos/mach-origen.c              |   6 +
 arch/arm/mach-exynos/mach-smdk4x12.c            |   6 +
 arch/arm/mach-exynos/mach-smdkv310.c            |   7 +
 arch/arm/mach-imx/Kconfig                       |   1 +
 arch/arm/mach-imx/mach-mx27_3ds.c               |  21 +-
 arch/arm/mach-ks8695/Kconfig                    |  61 ++++++
 arch/arm/mach-ks8695/Makefile                   |   8 +
 arch/arm/mach-ks8695/board-og.c                 | 199 +++++++++++++++++++
 arch/arm/mach-ks8695/board-sg.c                 | 121 +++++++++++
 arch/arm/mach-mmp/include/mach/debug-macro.S    |  12 +-
 arch/arm/mach-mmp/ttc_dkb.c                     |  10 +
 arch/arm/mach-msm/Kconfig                       |   8 +-
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |  11 -
 arch/arm/mach-msm/include/mach/msm_iomap.h      |   3 +-
 arch/arm/mach-msm/io.c                          |   2 -
 arch/arm/mach-s3c64xx/mach-crag6410-module.c    |  36 +++-
 arch/arm/mach-s3c64xx/mach-crag6410.c           |  12 ++
 arch/arm/mach-shmobile/board-armadillo800eva.c  |  25 +++
 arch/arm/mach-shmobile/board-marzen.c           |  68 ++++++-
 26 files changed, 633 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-ks8695/board-og.c
 create mode 100644 arch/arm/mach-ks8695/board-sg.c
