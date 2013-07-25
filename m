From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 25 Jul 2013 11:13:40 +0900
Subject: [PATCH v2 0/3] ARM: shmobile: marzen: Switch to DT_MACHINE_START
Message-ID: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A short series to use DT_MACHINE_START on the marzen board.

Changes since v1

* Add "ARM: shmobile: marzen: Enable ARM_APPENDED_DTB in defconfig" patch
* Add "ARM: shmobile: r8a7779: Rely on DT for SMP CPU info" patch
* Enhance "ARM: shmobile: marzen: Switch to DT_MACHINE_START" to:
  - Select USE_OF in Kconfig
  - Provide dt_compat in DT_MACHINE_START
  - Provide r8a7779-marzen dts

Magnus Damm (1):
  ARM: shmobile: marzen: Switch to DT_MACHINE_START

Simon Horman (2):
  ARM: shmobile: r8a7779: Rely on DT for SMP CPU info
  ARM: shmobile: marzen: Enable ARM_APPENDED_DTB in defconfig

 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/r8a7779-marzen.dts  | 27 +++++++++++++++++++++++++++
 arch/arm/configs/marzen_defconfig     |  1 +
 arch/arm/mach-shmobile/Kconfig        |  1 +
 arch/arm/mach-shmobile/board-marzen.c |  8 +++++++-
 arch/arm/mach-shmobile/smp-r8a7779.c  | 12 +++---------
 6 files changed, 40 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7779-marzen.dts

-- 
1.8.2.1
