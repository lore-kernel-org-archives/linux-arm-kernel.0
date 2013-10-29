From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 16:23:10 +0100
Subject: [PATCH 0/3] ARM: shmobile: Lager reference serial port support
Message-ID: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set implements serial port support for the Lager reference board,
and adds early debugging support for the r8a7790 SoC.

The code is available in my git tree at

        git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/serial-lager

The branch is based on a merge of renesas-devel-20131016, v3.12-rc7 and
multiarch drivers, clk-prepare, r8a7790 CCF and sh-sci OF patches I've posted
earlier today.

Laurent Pinchart (3):
  ARM: shmobile: r8a7790: Add early debugging support
  ARM: shmobile: r8a7790: Add serial ports to the device tree
  ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT

 arch/arm/Kconfig.debug                         |   8 ++
 arch/arm/boot/dts/r8a7790-lager.dts            |  24 +++++-
 arch/arm/boot/dts/r8a7790.dtsi                 | 100 +++++++++++++++++++++++++
 arch/arm/include/debug/r8a7790.S               |  43 +++++++++++
 arch/arm/mach-shmobile/board-lager-reference.c |  18 +----
 arch/arm/mach-shmobile/setup-r8a7790.c         |  12 +--
 6 files changed, 179 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/include/debug/r8a7790.S

-- 
Regards,

Laurent Pinchart
