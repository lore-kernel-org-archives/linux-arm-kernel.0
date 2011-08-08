From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:10:18 +0100
Subject: [PATCH 0/6] Miscellaneous patches for 3.1 and 3.2
Message-ID: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a bit of a strange mix of patches that I've got lying around on
top of -rc1.

The following patches are fixes and I'd like to put them into Russell's
patch system in the near future:

  ARM: realview: ensure visibility of writes during reset
  ARM: twd: register clockevents device before enabling PPI
  ARM: cache: detect VIPT aliasing I-cache on ARMv6

The other patches can wait until closer to the next merge window and I'd
welcome any feedback on those. The boot CPU number patch is probably the
most controversial given that I doubt many platforms can support booting
on anything other than CPU0 (although my Realview-PBX is happy enough).

Will


Will Deacon (6):
  ARM: vexpress: determine active tile site before reading tile ID
  ARM: realview: ensure visibility of writes during reset
  ARM: twd: register clockevents device before enabling PPI
  ARM: smp: set thread_info->cpu to hardware CPU number for boot thread
  ARM: cache: detect VIPT aliasing I-cache on ARMv6
  ARM: cache: detect PIPT I-cache using CTR

 arch/arm/include/asm/cachetype.h                  |    5 +++-
 arch/arm/kernel/setup.c                           |   30 ++++++++++++++------
 arch/arm/kernel/smp.c                             |   16 +++++++++++
 arch/arm/kernel/smp_twd.c                         |    4 +-
 arch/arm/mach-realview/include/mach/system.h      |    1 +
 arch/arm/mach-vexpress/include/mach/motherboard.h |    5 +++
 arch/arm/mach-vexpress/v2m.c                      |    6 +++-
 7 files changed, 53 insertions(+), 14 deletions(-)
