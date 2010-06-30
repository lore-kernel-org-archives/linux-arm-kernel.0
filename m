From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Jun 2010 15:06:23 +0300
Subject: [PATCH 00/16] omap mux updates for 2.6.36 merge window
Message-ID: <20100630120226.2637.31198.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series converts the remaining mach-omap2 code to use the
new mux framework that's already in use for omap3. After this
series we still need to add the mux data for omap4.

Regards,

Tony

---

Tony Lindgren (16):
      omap: mux: Fix omap_mux_init_gpio for omap24xx
      omap: mux: Renumber package defines to make room for older 24xx packages
      omap: mux: Allow compiling in new mux code on all mach-omap2 systems
      omap: mux: Remove unncessary parens from mux34xx.c
      omap: mux: Add data for 2420
      omap: mux: Add data for 2430
      omap: mux: Select SIP package for H4
      omap: mux: Select POP package for Apollon
      omap: mux: Select POP package for N8X0
      omap: mux: Select POP package for 2430SDP
      omap: mux: Make omap2 FS USB code use new mux functions
      omap: mux: Do keypad muxing in board-*.c files
      omap: mux: Mux Apollon LCD power in board-apollon.c
      omap: mux: Mux 2430 USB0HS_STP in board-2430.c
      omap: mux: Convert 2420 platform init code to use new mux code
      omap: mux: Remove old mux code


 arch/arm/mach-omap1/board-fsample.c          |   12 
 arch/arm/mach-omap1/board-h2.c               |   13 
 arch/arm/mach-omap1/board-h3.c               |   13 
 arch/arm/mach-omap1/board-perseus2.c         |   12 
 arch/arm/mach-omap2/Kconfig                  |   10 
 arch/arm/mach-omap2/Makefile                 |    2 
 arch/arm/mach-omap2/board-2430sdp.c          |   15 
 arch/arm/mach-omap2/board-3630sdp.c          |    1 
 arch/arm/mach-omap2/board-apollon.c          |   28 +
 arch/arm/mach-omap2/board-generic.c          |    1 
 arch/arm/mach-omap2/board-h4.c               |   36 +
 arch/arm/mach-omap2/board-n8x0.c             |   11 
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 
 arch/arm/mach-omap2/board-rx51-video.c       |    1 
 arch/arm/mach-omap2/devices.c                |   25 -
 arch/arm/mach-omap2/i2c.c                    |   27 -
 arch/arm/mach-omap2/io.c                     |    2 
 arch/arm/mach-omap2/mcbsp.c                  |   13 
 arch/arm/mach-omap2/mux.c                    |  308 ----------
 arch/arm/mach-omap2/mux.h                    |   28 +
 arch/arm/mach-omap2/mux2420.c                |  688 +++++++++++++++++++++++
 arch/arm/mach-omap2/mux2420.h                |  282 +++++++++
 arch/arm/mach-omap2/mux2430.c                |  791 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux2430.h                |  370 ++++++++++++
 arch/arm/mach-omap2/mux34xx.c                |    8 
 arch/arm/mach-omap2/pm24xx.c                 |    1 
 arch/arm/mach-omap2/usb-ehci.c               |    1 
 arch/arm/mach-omap2/usb-fs.c                 |   33 +
 arch/arm/mach-omap2/usb-musb.c               |    1 
 arch/arm/mach-omap2/usb-tusb6010.c           |   14 
 arch/arm/plat-omap/devices.c                 |   61 --
 arch/arm/plat-omap/include/plat/mux.h        |  220 -------
 arch/arm/plat-omap/mux.c                     |    2 
 drivers/usb/musb/omap2430.c                  |    4 
 drivers/video/omap/lcd_apollon.c             |    3 
 35 files changed, 2359 insertions(+), 679 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mux2420.c
 create mode 100644 arch/arm/mach-omap2/mux2420.h
 create mode 100644 arch/arm/mach-omap2/mux2430.c
 create mode 100644 arch/arm/mach-omap2/mux2430.h

-- 
Signature
