From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 14:14:20 +0100
Subject: [PATCH v3 0/4] Lager and Koelsch reference serial port support
Message-ID: <1386767664-20113-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set implements serial port support for the Lager reference board.

The code is available in my git tree at

        git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/serial/boards

The patches are based on top of the "[PATCH 00/47] sh-sci updates for v3.14"
and "[PATCH v3 00/15] Lager and Koelsch multiplatform support" patch series.

Changes compared to v2:

- Added Koelsch support

Changes compared to v1:

- Removed early debugging support as it requires more work before being
  mainlined

Laurent Pinchart (4):
  ARM: shmobile: r8a7790: Add serial ports to the device tree
  ARM: shmobile: r8a7791: Add serial ports to the device tree
  ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
  ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT

 arch/arm/boot/dts/r8a7790-lager.dts              |  24 ++-
 arch/arm/boot/dts/r8a7790.dtsi                   | 100 +++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts            |  24 ++-
 arch/arm/boot/dts/r8a7791.dtsi                   | 180 +++++++++++++++++++++++
 arch/arm/mach-shmobile/board-koelsch-reference.c |  18 +--
 arch/arm/mach-shmobile/board-lager-reference.c   |  18 +--
 arch/arm/mach-shmobile/clock-r8a7790.c           |  16 +-
 arch/arm/mach-shmobile/clock-r8a7791.c           |  24 +--
 arch/arm/mach-shmobile/setup-r8a7790.c           |  26 ++--
 arch/arm/mach-shmobile/setup-r8a7791.c           |  34 ++---
 10 files changed, 374 insertions(+), 90 deletions(-)

-- 
Regards,

Laurent Pinchart
