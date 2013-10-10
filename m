From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Oct 2013 15:20:39 -0700
Subject: [PATCH 0/8] Make few omap3 boards device tree only
Message-ID: <20131010221833.9063.49904.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Now that we have the remaining omap3 PM related wake-up
events mostly resolved, it's time to start making omap3
to be device tree only.

These are the boards that I'm using for testing in my
rack setup, so I've verified that the basic features work
well enough for me so we can make them device tree only.

Patches are welcome to add more features :)

Regards,

Tony

---

Tony Lindgren (8):
      ARM: OMAP2+: Use pdata quirks for wl12xx for omap3 evm and zoom3
      ARM: OMAP2+: Add minimal 8250 support for GPMC
      ARM: dts: Shared file for omap GPMC connected smsc911x
      ARM: dts: Add common support for omap3-evm
      ARM: dts: Add basic support for TMDSEVM3730 (Mistral AM/DM37x EVM)
      ARM: dts: Add basic support for zoom3
      ARM: OMAP2+: Remove legacy booting support for omap3 EVM
      ARM: OMAP2+: Remove legacy support for zoom platforms


 arch/arm/boot/dts/Makefile                   |    2 
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi    |   52 ++
 arch/arm/boot/dts/omap-zoom-common.dtsi      |   33 +
 arch/arm/boot/dts/omap3-evm-37xx.dts         |  146 +++++
 arch/arm/boot/dts/omap3-evm-common.dtsi      |   96 +++
 arch/arm/boot/dts/omap3-evm.dts              |   58 --
 arch/arm/boot/dts/omap3-igep0020.dts         |   45 --
 arch/arm/boot/dts/omap3-zoom3.dts            |  217 +++++++
 arch/arm/mach-omap2/Kconfig                  |   26 -
 arch/arm/mach-omap2/Makefile                 |   10 
 arch/arm/mach-omap2/board-3630sdp.c          |  225 --------
 arch/arm/mach-omap2/board-ldp.c              |    3 
 arch/arm/mach-omap2/board-omap3evm.c         |  756 --------------------------
 arch/arm/mach-omap2/board-zoom-debugboard.c  |  139 -----
 arch/arm/mach-omap2/board-zoom-display.c     |   71 --
 arch/arm/mach-omap2/board-zoom-peripherals.c |  360 ------------
 arch/arm/mach-omap2/board-zoom.c             |  159 -----
 arch/arm/mach-omap2/board-zoom.h             |   10 
 arch/arm/mach-omap2/gpmc.c                   |   38 +
 arch/arm/mach-omap2/pdata-quirks.c           |   12 
 20 files changed, 601 insertions(+), 1857 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
 create mode 100644 arch/arm/boot/dts/omap-zoom-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-evm-37xx.dts
 create mode 100644 arch/arm/boot/dts/omap3-evm-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-zoom3.dts
 delete mode 100644 arch/arm/mach-omap2/board-3630sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3evm.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-debugboard.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-display.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom.h

-- 
Signature
