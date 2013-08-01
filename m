From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:14 +0900
Subject: [GIT 00/14] Second round of Renesas ARM based SoC cleanups for v3.12
Message-ID: <cover.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please consider this second round of Renesas ARM based SoC cleanups for
v3.12.

This pull-request is based on a merge of renesas-tpu-pwm-for-v3.12,
renesas-backlight-for-v3.12 and renesas-soc-for-v3.12, each of which
I have previously sent a pull-request for, in order to provide
the pre-requisite code that that is being removed or cleaned up.

The following changes since commit 4431374926363df1d907d9c8783f473eb7facf42:

  Merge branches 'tpu-pwm', 'backlight' and 'soc' into cleanup2-base (2013-07-24 16:35:12 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup2-for-v3.12

for you to fetch changes up to 98724b7ec9d34d875fc193660c87d6dd0d17ceb7:

  ARM: shmobile: r8a7779: Remove '0x's from R8A7779 DTS file (2013-07-30 14:21:43 +0900)

----------------------------------------------------------------
Second round of Renesas ARM based SoC cleanups for v3.12

* Remove mach/hardware.h which has no useful contents
* Remove ag5evm board support
* Remove kota2 board support
* Use pm-rmobile on sh7372 and r8a7740 SoCs only, it is otherwise unneeded
* Remove use of INTC header on r8a7779 and r8a7740 SoCs
* Cleanup registration of usb phy in r8a7779 SoC
* Remove '0x's from R8A7779 DTS file for r8a7779 SoC

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: r8a7779: cleanup registration of usb phy

Lee Jones (1):
      ARM: shmobile: r8a7779: Remove '0x's from R8A7779 DTS file

Magnus Damm (10):
      ARM: shmobile: Remove sh73a0 use of <mach/hardware.h>
      ARM: shmobile: Remove sh7372 use of <mach/hardware.h>
      ARM: shmobile: Remove EMEV2 use of <mach/hardware.h>
      ARM: shmobile: Remove r8a7779 use of <mach/hardware.h>
      ARM: shmobile: Remove Marzen use of <mach/hardware.h>
      ARM: shmobile: Remove include <mach/hardware.h>
      ARM: shmobile: r8a73a4: Remove ->init_machine() special case
      ARM: shmobile: Use pm-rmobile on sh7372 and r8a7740 only
      ARM: shmobile: No need to use INTC demux on r8a7740
      ARM: shmobile: No need to use INTC header on r8a7779

Simon Horman (2):
      ARCH: ARM: shmobile: Remove kota2 board support
      ARCH: ARM: shmobile: Remove ag5evm board support

 arch/arm/boot/dts/r8a7779.dtsi                 |   8 +-
 arch/arm/configs/ag5evm_defconfig              |  83 ----
 arch/arm/configs/kota2_defconfig               | 121 -----
 arch/arm/mach-shmobile/Kconfig                 |  13 -
 arch/arm/mach-shmobile/Makefile                |  10 +-
 arch/arm/mach-shmobile/Makefile.boot           |   2 -
 arch/arm/mach-shmobile/board-ag5evm.c          | 639 -------------------------
 arch/arm/mach-shmobile/board-kota2.c           | 550 ---------------------
 arch/arm/mach-shmobile/board-marzen.c          |  25 +-
 arch/arm/mach-shmobile/include/mach/hardware.h |   4 -
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |   2 -
 arch/arm/mach-shmobile/intc-r8a7779.c          |   1 -
 arch/arm/mach-shmobile/setup-emev2.c           |   1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c         |   6 -
 arch/arm/mach-shmobile/setup-r8a7779.c         |  19 -
 arch/arm/mach-shmobile/setup-sh7372.c          |   1 -
 arch/arm/mach-shmobile/setup-sh73a0.c          |   1 -
 17 files changed, 29 insertions(+), 1457 deletions(-)
 delete mode 100644 arch/arm/configs/ag5evm_defconfig
 delete mode 100644 arch/arm/configs/kota2_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-ag5evm.c
 delete mode 100644 arch/arm/mach-shmobile/board-kota2.c
 delete mode 100644 arch/arm/mach-shmobile/include/mach/hardware.h
