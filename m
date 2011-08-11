From: leoy@marvell.com (Leo Yan)
Date: Thu, 11 Aug 2011 10:31:59 +0800
Subject: [PATCH V3 0/2] ARM: mmp: add audio sram support
Message-ID: <1313029921-32227-1-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mmp platform, there have several sram banks for
audio, video and PM. So add the sram module to manage
these sram banks.

And register audio sram bank for allocating to versatile
pcm devices.

Leo Yan (2):
  ARM: mmp: add sram allocator
  ARM: mmp: register audio sram bank

 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-mmp/Makefile            |    2 +-
 arch/arm/mach-mmp/brownstone.c        |    5 +
 arch/arm/mach-mmp/include/mach/mmp2.h |    7 ++
 arch/arm/mach-mmp/include/mach/sram.h |   35 +++++++
 arch/arm/mach-mmp/mmp2.c              |    1 +
 arch/arm/mach-mmp/sram.c              |  168 +++++++++++++++++++++++++++++++++
 7 files changed, 218 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/sram.h
 create mode 100644 arch/arm/mach-mmp/sram.c

-- 
1.7.4.1
