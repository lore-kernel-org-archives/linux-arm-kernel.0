From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 19:23:20 +0200
Subject: [PATCH 0/4] ARM architecture fixes
Message-ID: <1367515404-512212-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

These are four bug fixes that came out of my build testing.
The first one replaces a patch I put into the patch tracker
earlier but had to retract because it broke THUMB2_KERNEL.

The other three are for recent regressions coming from your
tree.

	Arnd

Arnd Bergmann (4):
  ARM: compressed/head.S: work around new binutils warning
  ARM: fix prototypes for arch_ioremap_caller functions
  ARM: fix NOMMU __arm_ioremap prototype
  ARM: highbank: fix build after cache flush change

 arch/arm/boot/compressed/Makefile      | 2 +-
 arch/arm/boot/compressed/head-sa1100.S | 1 +
 arch/arm/boot/compressed/head-shark.S  | 1 +
 arch/arm/boot/compressed/head.S        | 1 +
 arch/arm/mach-ebsa110/core.c           | 2 +-
 arch/arm/mach-highbank/hotplug.c       | 1 +
 arch/arm/mach-imx/mm-imx3.c            | 2 +-
 arch/arm/mach-iop13xx/io.c             | 2 +-
 arch/arm/mach-ixp4xx/common.c          | 2 +-
 arch/arm/mach-msm/common.h             | 2 +-
 arch/arm/mach-msm/io.c                 | 2 +-
 arch/arm/mm/nommu.c                    | 4 ++--
 12 files changed, 13 insertions(+), 9 deletions(-)

-- 
1.8.1.2
