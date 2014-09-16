From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 16 Sep 2014 12:45:41 +0800
Subject: [GIT PULL 1/3] ARM: imx: cleanup for 3.18
Message-ID: <20140916044540.GA25583@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-3.18

for you to fetch changes up to 64d14a31d5410ea34641c41795e0ba222bda740c:

  ARM: imx: Remove mach-mxt_td60 board file (2014-09-10 11:17:44 +0800)

----------------------------------------------------------------
The i.MX cleanup for 3.18:
 - Reomve a few i.MX27 and i.MX1 board files
 - Remove imx_scu_standby_enable() since core code handles scu
   standby now
 - Remove unnecessary iomux declaration
 - Remove useless sound card property from vf610-twr dts

----------------------------------------------------------------
Alexander Shiyan (3):
      ARM: i.MX: Remove mach-cpuimx27sd board file
      ARM: i.MX: Remove Phytec i.MX27 PCM038/PCM970 board files
      ARM: i.MX: Remove i.MX1 ADS board support

Alexander Stein (1):
      ARM: imx: iomux: Do not export symbol without public declaration

Fabio Estevam (1):
      ARM: imx: Remove mach-mxt_td60 board file

Shawn Guo (1):
      ARM: imx: remove imx_scu_standby_enable()

Xiubo Li (1):
      ARM: dts: vf610-twr: remove useless property for sound card.

 arch/arm/boot/dts/vf610-twr.dts              |   1 -
 arch/arm/configs/imx_v4_v5_defconfig         |   5 -
 arch/arm/mach-imx/Kconfig                    | 103 --------
 arch/arm/mach-imx/Makefile                   |   6 -
 arch/arm/mach-imx/board-pcm038.h             |  36 ---
 arch/arm/mach-imx/common.h                   |   2 -
 arch/arm/mach-imx/cpuidle-imx6q.c            |   4 -
 arch/arm/mach-imx/eukrea-baseboards.h        |  10 +-
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c | 351 --------------------------
 arch/arm/mach-imx/iomux-imx31.c              |   7 -
 arch/arm/mach-imx/iomux-v1.c                 |   2 -
 arch/arm/mach-imx/iomux-v3.c                 |   2 -
 arch/arm/mach-imx/mach-cpuimx27.c            | 321 ------------------------
 arch/arm/mach-imx/mach-mx1ads.c              | 154 ------------
 arch/arm/mach-imx/mach-mxt_td60.c            | 273 --------------------
 arch/arm/mach-imx/mach-pcm038.c              | 358 ---------------------------
 arch/arm/mach-imx/pcm970-baseboard.c         | 231 -----------------
 arch/arm/mach-imx/platsmp.c                  |  10 -
 18 files changed, 1 insertion(+), 1875 deletions(-)
 delete mode 100644 arch/arm/mach-imx/board-pcm038.h
 delete mode 100644 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
 delete mode 100644 arch/arm/mach-imx/mach-cpuimx27.c
 delete mode 100644 arch/arm/mach-imx/mach-mx1ads.c
 delete mode 100644 arch/arm/mach-imx/mach-mxt_td60.c
 delete mode 100644 arch/arm/mach-imx/mach-pcm038.c
 delete mode 100644 arch/arm/mach-imx/pcm970-baseboard.c
