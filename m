From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Mar 2013 19:35:35 +0800
Subject: [PATCH v4 0/2] Uncompress debug for multiplatform
Message-ID: <1363001737-8745-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of giving zero support of uncompress debug for multiplatform
build, the series turns uncompress debug into one part of DEBUG_LL
support.  When DEBUG_LL is turned on for a particular platform,
uncompress debug works too for that platform.

OMAP is an exception here.  OMAP low-level debug code places data
in the .data section, and that is allowed in decompressor.  That's
why Kconfig symbol DEBUG_UNCOMPRESS that controls multiplatform
uncompress debug support is defined with !DEBUG_OMAP2PLUS_UART.

Changes since v3:
 - Create Kconfig symbol DEBUG_UNCOMPRESS for building in
   multiplatform uncompress debug support, so that we can leave
   out the platform which is part of multiplatform but not ready
   for being part of uncompress debug like OMAP example.

Shawn Guo (2):
  ARM: use Kconfig to select uncompress.h
  ARM: uncompress debug support for multiplatform build

 arch/arm/Kconfig.debug              |    9 +++++++++
 arch/arm/boot/compressed/Makefile   |    3 +++
 arch/arm/boot/compressed/debug.S    |   12 ++++++++++++
 arch/arm/boot/compressed/misc.c     |    8 +-------
 arch/arm/include/debug/uncompress.h |    7 +++++++
 5 files changed, 32 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/compressed/debug.S
 create mode 100644 arch/arm/include/debug/uncompress.h

-- 
1.7.9.5
