From: leoy@marvell.com (Leo Yan)
Date: Mon, 15 Aug 2011 11:09:51 +0800
Subject: [PATCH V4 0/3] ARM: mmp: add audio sram support
Message-ID: <1313377794-26721-1-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mmp platform, there have two sram banks:
audio sram bank, and internal sram bank for video and PM.
So add the sram module to manage these sram banks.

And register the sram banks so can dynamically alloc/free
the buffer.

Leo Yan (3):
  ARM: mmp: add sram allocator
  ARM: mmp: register audio sram bank
  ARM: mmp: register internal sram bank

 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-mmp/Makefile            |    2 +-
 arch/arm/mach-mmp/brownstone.c        |   11 ++
 arch/arm/mach-mmp/include/mach/mmp2.h |   13 +++
 arch/arm/mach-mmp/include/mach/sram.h |   35 +++++++
 arch/arm/mach-mmp/mmp2.c              |    3 +
 arch/arm/mach-mmp/sram.c              |  168 +++++++++++++++++++++++++++++++++
 7 files changed, 232 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/sram.h
 create mode 100644 arch/arm/mach-mmp/sram.c

-- 
1.7.4.1
