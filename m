From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 May 2012 12:00:59 -0700
Subject: [PATCH 0/4] omap legacy full speed usb cleanup for v3.6
Message-ID: <20120521185323.927.88012.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series removes the old legacy fulls speed support for
omap2 as it's pretty much only used for omap1 only.

For omap2, only n8x0 seems to have active development, and
that has the external high speed tusb chip instead.

This allows removes the last user of omap_read/write for omap2+,
removes cpu_is_omapxxx usage under drivers/usb except for omap1,
simplifies the plat/usb.h allowing further clean-up, simplifies
the DMA engine conversion by one driver, and so on.

The patches are against today's linux next branch.

Regards,

Tony


---

Tony Lindgren (4):
      ARM: OMAP3: There is no FS USB controller on omap3
      ARM: OMAP2: Remove legacy USB FS support
      ARM: OMAP: Make FS USB omap1 only
      USB: Remove omap2 support from omap_udc.c


 arch/arm/mach-omap1/board-ams-delta.c   |    2 
 arch/arm/mach-omap1/board-generic.c     |    4 
 arch/arm/mach-omap1/board-h2.c          |    2 
 arch/arm/mach-omap1/board-h3.c          |    2 
 arch/arm/mach-omap1/board-htcherald.c   |    2 
 arch/arm/mach-omap1/board-innovator.c   |    2 
 arch/arm/mach-omap1/board-nokia770.c    |    2 
 arch/arm/mach-omap1/board-osk.c         |    2 
 arch/arm/mach-omap1/board-palmte.c      |    2 
 arch/arm/mach-omap1/board-palmtt.c      |    2 
 arch/arm/mach-omap1/board-palmz71.c     |    2 
 arch/arm/mach-omap1/board-sx1.c         |    2 
 arch/arm/mach-omap1/board-voiceblue.c   |    3 
 arch/arm/mach-omap1/clock_data.c        |    3 
 arch/arm/mach-omap1/include/mach/usb.h  |  165 ++++++++++++++
 arch/arm/mach-omap1/usb.c               |  116 ++++++++++
 arch/arm/mach-omap2/Kconfig             |    3 
 arch/arm/mach-omap2/Makefile            |    3 
 arch/arm/mach-omap2/board-2430sdp.c     |   11 -
 arch/arm/mach-omap2/board-apollon.c     |   18 --
 arch/arm/mach-omap2/board-h4.c          |   13 -
 arch/arm/mach-omap2/usb-fs.c            |  359 -------------------------------
 arch/arm/plat-omap/Makefile             |    2 
 arch/arm/plat-omap/include/plat/board.h |   38 ---
 arch/arm/plat-omap/include/plat/usb.h   |  196 -----------------
 arch/arm/plat-omap/usb.c                |  145 -------------
 drivers/usb/gadget/Kconfig              |    2 
 drivers/usb/gadget/omap_udc.c           |  116 ++--------
 drivers/usb/host/Kconfig                |    2 
 drivers/usb/host/ohci-omap.c            |    7 -
 drivers/usb/otg/isp1301_omap.c          |    2 
 31 files changed, 333 insertions(+), 897 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/usb.h
 delete mode 100644 arch/arm/mach-omap2/usb-fs.c
 delete mode 100644 arch/arm/plat-omap/usb.c

-- 
Signature
