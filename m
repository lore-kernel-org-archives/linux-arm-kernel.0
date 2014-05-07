From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 May 2014 08:32:19 +0900
Subject: [PATCH 00/04] ARM: shmobile: Use shmobile_init_delay() on r8a7740
Message-ID: <20140507233219.29712.9253.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Use shmobile_init_delay() on r8a7740

[PATCH 01/04] ARM: shmobile: Add r8a7740 Maximum CPU Frequency to DTS
[PATCH 02/04] ARM: shmobile: Use r8a7740 DT CPU Frequency in common case	
[PATCH 03/04] ARM: shmobile: Use r8a7740 DT CPU Frequency for Armadillo DT Ref
[PATCH 04/04] ARM: shmobile: Remove unused r8a7740_init_delay()

Convert r8a7740 to rely on shmobile_init_delay() instead of using a per-SoC
delay setup function. This is a cleanup towards enabling Multiplatform support
for the r8a7740 SoC.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-v3.15-rc3-20140502

 arch/arm/boot/dts/r8a7740.dtsi                           |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h            |    1 -
 arch/arm/mach-shmobile/setup-r8a7740.c                   |    7 +------
 4 files changed, 3 insertions(+), 8 deletions(-)
