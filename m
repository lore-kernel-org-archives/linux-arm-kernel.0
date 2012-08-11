From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 11 Aug 2012 02:39:44 +0000
Subject: [PATCH 0/3] ARM: Kirkwood: update defconfig and fix ts219 dtb
Message-ID: <cover.1344651264.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small series to update kirkwood_defconfig to include all of the new
DT boards.  And, finally, SERIAL_OF_PLATFORM is enabled. ;-)

There is one small fix for ts219.  When it was revised to split into two dts
files, Makefile.boot wasn't updated.  This caused a build failure for
'make dtbs'

Jason Cooper (3):
  ARM: Kirkwood: update defconfig
  ARM: Kirkwood: ts219: fix Makefile.boot after dts was split in two
  ARM: Kirkwood: add DT boards to defconfig

 arch/arm/configs/kirkwood_defconfig  |   37 +++++++++++++++------------------
 arch/arm/mach-kirkwood/Makefile.boot |    2 +-
 2 files changed, 18 insertions(+), 21 deletions(-)

-- 
1.7.8.6
