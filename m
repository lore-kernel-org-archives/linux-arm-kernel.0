From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Nov 2009 15:26:29 -0800
Subject: [PATCH 00/12] Mostly board updates for 2.6.33 merge window
Message-ID: <20091116232435.24892.81547.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some patches for review. This series is mostly updates
to existing omap board files. It also adds support for zoom3 board,
and contains few clean-up patches.

Regards,

Tony

---

Ajay Kumar Gupta (2):
      omap3evm: Add board revision function
      omap3evm: ehci: Update EHCI support on OMAP3EVM (Rev >= E)

Anand Gadiyar (1):
      omap3: Update 3430SDP defconfig

Charulatha V (1):
      omap: GPIO module enable/disable

Felipe Balbi (1):
      omap: Cleanup the coding style in id.c

Mike Rapoport (1):
      omap3evm: Initialize vmmc and vmmc_aux regulators

Sriram (1):
      omap3evm: MIgrate to smsc911x ethernet driver

vikram pandita (5):
      omap3: defconfigs: remove SYSFS_DEPRECATED flag
      omap3: zoom: split board file for software reuse
      omap3: zoom: rename zoom2 name to generic zoom
      omap3: zoom: Drop i2c-1 speed to 2400
      omap3: zoom: Introduce zoom3 board support


 arch/arm/configs/omap3_beagle_defconfig            |    4 
 arch/arm/configs/omap3_evm_defconfig               |   20 
 arch/arm/configs/omap3_pandora_defconfig           |    5 
 arch/arm/configs/omap_3430sdp_defconfig            |  998 ++++++--------------
 arch/arm/configs/omap_4430sdp_defconfig            |    4 
 arch/arm/configs/omap_ldp_defconfig                |    4 
 arch/arm/configs/omap_zoom2_defconfig              |    4 
 arch/arm/configs/overo_defconfig                   |    4 
 arch/arm/mach-omap2/Kconfig                        |    4 
 arch/arm/mach-omap2/Makefile                       |    5 
 arch/arm/mach-omap2/board-omap3evm.c               |  156 +++
 arch/arm/mach-omap2/board-zoom-debugboard.c        |   70 +
 arch/arm/mach-omap2/board-zoom-peripherals.c       |  267 +++++
 arch/arm/mach-omap2/board-zoom2.c                  |  236 -----
 arch/arm/mach-omap2/board-zoom3.c                  |   59 +
 arch/arm/mach-omap2/id.c                           |   61 -
 arch/arm/mach-omap2/include/mach/board-zoom.h      |    5 
 arch/arm/mach-omap2/mux.c                          |    7 
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   51 +
 arch/arm/plat-omap/gpio.c                          |   32 +
 arch/arm/plat-omap/include/plat/board.h            |   18 
 arch/arm/plat-omap/include/plat/mux.h              |    5 
 22 files changed, 983 insertions(+), 1036 deletions(-)
 create mode 100755 arch/arm/mach-omap2/board-zoom-peripherals.c
 create mode 100644 arch/arm/mach-omap2/board-zoom3.c
 create mode 100644 arch/arm/mach-omap2/include/mach/board-zoom.h
 create mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h

-- 
Signature
