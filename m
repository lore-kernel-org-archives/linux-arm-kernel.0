From: rogerq@ti.com (Roger Quadros)
Date: Tue, 19 Mar 2013 16:26:58 +0200
Subject: [RFC][PATCH 0/2] Device tree support for OMAP4 SCRM clocks
Message-ID: <1363703220-4777-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Based on the discussion in [1], I've implemented device tree
provider for the AUXCLKs on OMAP4.

Please let me know if there are any issues.

This is important to get USB Host support working on Panda with
device tree boot on 3.10.

Roger Quadros (2):
  ARM: OMAP4: clock: Add device tree support for AUXCLKs
  ARM: dts: omap4-panda: Provide PHY clock information

 .../devicetree/bindings/clock/omap4-clock.txt      |   32 ++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |    2 +
 arch/arm/boot/dts/omap4.dtsi                       |    5 +++
 arch/arm/mach-omap2/board-generic.c                |    2 +-
 arch/arm/mach-omap2/cclock44xx_data.c              |   35 ++++++++++++++++++++
 arch/arm/mach-omap2/clock44xx.h                    |    1 +
 arch/arm/mach-omap2/common.h                       |    9 +++++
 arch/arm/mach-omap2/io.c                           |    6 +++
 8 files changed, 91 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/omap4-clock.txt

-- 
1.7.4.1
