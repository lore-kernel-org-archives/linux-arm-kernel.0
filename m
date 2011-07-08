From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Jul 2011 06:01:02 -0700
Subject: [GIT PULL] omap twl cleanup for v3.1 merge window
Message-ID: <20110708130102.GB5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull TWL cleanup from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git cleanup-part-2

This can be pulled into your omap/cleanup. It will cause a minor
merge conflict with omap/board.

I've attached a conflict resolution patch too, it's trivial execpt
note that .vdac needs to be removed in board-rx51-peripherals.c.

If this conflict causes problems for you, I can also base this series
on omap/board.

Regards,

Tony


The following changes since commit 48cb1258e8b0f8c81cfb699b42326c5b2147b3f8:
  Tony Lindgren (1):
        Merge branch 'for_3.1/pm-misc' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git cleanup-part-2

Jarkko Nikula (2):
      omap: mcbsp: Remove rx_/tx_word_length variables
      omap: mcbsp: Remove port number enums

Peter Ujfalusi (4):
      OMAP: New twl-common for common TWL configuration
      OMAP4: Move common twl6030 configuration to twl-common
      OMAP3: Move common twl configuration to twl-common
      OMAP3: Move common regulator configuration to twl-common

Tony Lindgren (1):
      Merge branch 'peter/topic/for-tony_mach-cleanup' of git://gitorious.org/omap-audio/linux-audio into cleanup-part-2

 arch/arm/mach-omap1/mcbsp.c                  |    4 +-
 arch/arm/mach-omap2/Makefile                 |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |   89 +-------
 arch/arm/mach-omap2/board-4430sdp.c          |  141 +-----------
 arch/arm/mach-omap2/board-cm-t35.c           |   51 +----
 arch/arm/mach-omap2/board-devkit8000.c       |   38 +---
 arch/arm/mach-omap2/board-igep0020.c         |   44 +---
 arch/arm/mach-omap2/board-ldp.c              |   15 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |   62 +-----
 arch/arm/mach-omap2/board-omap3evm.c         |   70 +------
 arch/arm/mach-omap2/board-omap3pandora.c     |   62 +-----
 arch/arm/mach-omap2/board-omap3stalker.c     |   72 +------
 arch/arm/mach-omap2/board-omap3touchbook.c   |   61 +----
 arch/arm/mach-omap2/board-omap4panda.c       |  146 +-----------
 arch/arm/mach-omap2/board-overo.c            |   61 +-----
 arch/arm/mach-omap2/board-rm680.c            |    8 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   40 +---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   89 +-------
 arch/arm/mach-omap2/common-board-devices.c   |   21 --
 arch/arm/mach-omap2/common-board-devices.h   |   26 +--
 arch/arm/mach-omap2/twl-common.c             |  304 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl-common.h             |   59 +++++
 arch/arm/plat-omap/include/plat/mcbsp.h      |   12 +-
 arch/arm/plat-omap/mcbsp.c                   |    3 -
 24 files changed, 492 insertions(+), 988 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl-common.c
 create mode 100644 arch/arm/mach-omap2/twl-common.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: resolve.patch
Type: text/x-diff
Size: 2584 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110708/a96bac57/attachment.bin>
