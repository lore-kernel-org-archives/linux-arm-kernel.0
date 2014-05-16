From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 13:42:57 +0900
Subject: [PATCH 0/4] ARM: shmobile: r8a7779: Use shmobile_init_delay()
Message-ID: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use shmobile_init_delay() on r8a7779 SoC.

Convert r8a7779 to rely on shmobile_init_delay() instead of using a per-SoC
delay setup function. This is a cleanup towards enabling Multiplatform support
for the r8a7779 SoC.

Based on work for the r8a7740 SoC by Magnus Damm.

Based on the renesas-devel-v3.15-rc5-20140516
tag of my renesas tree.

Simon Horman (4):
  ARM: shmobile: r8a7779: Add Maximum CPU Frequency to DTS
  ARM: shmobile: r8a7779: Use DT CPU Frequency in common case
  ARM: shmobile: marzen-reference: Use DT CPU Frequency
  ARM: shmobile: r8a7779: Remove unused r8a7779_init_delay()

 arch/arm/boot/dts/r8a7779.dtsi                  | 4 ++++
 arch/arm/mach-shmobile/board-marzen-reference.c | 2 +-
 arch/arm/mach-shmobile/include/mach/r8a7779.h   | 1 -
 arch/arm/mach-shmobile/setup-r8a7779.c          | 7 +------
 4 files changed, 6 insertions(+), 8 deletions(-)

-- 
1.8.5.2
