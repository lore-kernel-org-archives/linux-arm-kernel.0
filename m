From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 00:51:20 +0200
Subject: [patch-v2.6.33-rc2+ 00/12] arm omap patches for next -rc
Message-ID: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

there are the patches I have for you for the next -rc

as per your request, they are now being sent to LAKML
and linux-usb.

Felipe Balbi (12):
  arm: omap: musb: ioremap only what's ours
  arm: omap: musb: fix board power budget by passing it to
    usb_musb_init
  arm: omap: musb: fix board mode by passing it to usb_musb_init
  arm: omap1: mailbox: kill compile warning
  arm: omap: gpmc: kill compile warning
  arm: omap: kill compile warning in irq.c
  arm: omap: remove unused variables
  arm: omap: io: kill compile warning
  arm: omap: kill compile warning on board-4430-sdp.c
  arm: omap: gpio: kill compile warning in gpio.c
  arm: omap: mailbox: kill compile warning in mailbox.c
  arm: omap: perseus: kill compile warning on board-perseus2.c

 arch/arm/mach-omap1/devices.c                |    2 +-
 arch/arm/mach-omap1/mailbox.c                |    9 +++++++--
 arch/arm/mach-omap2/board-2430sdp.c          |    3 ++-
 arch/arm/mach-omap2/board-3430sdp.c          |    3 ++-
 arch/arm/mach-omap2/board-4430sdp.c          |    4 ----
 arch/arm/mach-omap2/board-cm-t35.c           |    3 ++-
 arch/arm/mach-omap2/board-igep0020.c         |    3 ++-
 arch/arm/mach-omap2/board-ldp.c              |    3 ++-
 arch/arm/mach-omap2/board-omap3beagle.c      |    3 ++-
 arch/arm/mach-omap2/board-omap3evm.c         |    3 ++-
 arch/arm/mach-omap2/board-omap3pandora.c     |    3 ++-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    3 ++-
 arch/arm/mach-omap2/board-overo.c            |    3 ++-
 arch/arm/mach-omap2/board-rx51.c             |    3 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    3 ++-
 arch/arm/mach-omap2/gpmc.c                   |    6 ++++--
 arch/arm/mach-omap2/io.c                     |    2 ++
 arch/arm/mach-omap2/irq.c                    |    2 ++
 arch/arm/mach-omap2/mailbox.c                |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430.h        |    2 --
 arch/arm/mach-omap2/usb-musb.c               |   23 +++++++----------------
 arch/arm/plat-omap/gpio.c                    |    3 +++
 arch/arm/plat-omap/include/plat/fpga.h       |    4 ++--
 arch/arm/plat-omap/include/plat/usb.h        |    3 ++-
 24 files changed, 55 insertions(+), 43 deletions(-)
