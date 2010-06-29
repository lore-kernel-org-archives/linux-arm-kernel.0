From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jun 2010 14:54:06 +0300
Subject: [PATCH 0/4] Platform init changes for old FS USB code for 2.6.36
	merge window
Message-ID: <20100629115056.17702.56622.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some FS USB platform init changes to allow further improvment
of the code for muxing, register access and hwmod.

This set mostly moves the code around to split it between mach-omap1
and mach-omap2.

Regards,

Tony

---

Tony Lindgren (4):
      omap: Separate out omap2 FS USB platform init functions
      omap: Move omap2 FS USB platform init code into mach-omap2/usb-fs.c
      omap: Enable interface clock for omap2 FS USB
      omap: Move omap1 USB platform init code into mach-omap1/usb.c


 arch/arm/mach-omap1/Makefile            |    3 
 arch/arm/mach-omap1/board-ams-delta.c   |    2 
 arch/arm/mach-omap1/board-generic.c     |    4 
 arch/arm/mach-omap1/board-h2.c          |    2 
 arch/arm/mach-omap1/board-h3.c          |    2 
 arch/arm/mach-omap1/board-htcherald.c   |    2 
 arch/arm/mach-omap1/board-innovator.c   |    4 
 arch/arm/mach-omap1/board-nokia770.c    |    2 
 arch/arm/mach-omap1/board-osk.c         |    2 
 arch/arm/mach-omap1/board-palmte.c      |    2 
 arch/arm/mach-omap1/board-palmtt.c      |    2 
 arch/arm/mach-omap1/board-palmz71.c     |    2 
 arch/arm/mach-omap1/board-sx1.c         |    2 
 arch/arm/mach-omap1/board-voiceblue.c   |    2 
 arch/arm/mach-omap1/usb.c               |  530 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile            |    2 
 arch/arm/mach-omap2/board-2430sdp.c     |    2 
 arch/arm/mach-omap2/board-apollon.c     |    2 
 arch/arm/mach-omap2/board-h4.c          |    2 
 arch/arm/mach-omap2/usb-fs.c            |  356 +++++++++++++++++
 arch/arm/plat-omap/include/plat/board.h |    8 
 arch/arm/plat-omap/include/plat/usb.h   |   49 ++
 arch/arm/plat-omap/usb.c                |  644 +------------------------------
 23 files changed, 981 insertions(+), 647 deletions(-)
 create mode 100644 arch/arm/mach-omap1/usb.c
 create mode 100644 arch/arm/mach-omap2/usb-fs.c

-- 
Signature
