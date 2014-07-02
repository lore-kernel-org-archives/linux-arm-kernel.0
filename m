From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Jul 2014 06:28:36 +0200
Subject: [PATCH/RFC 0/6] ARM: shmobile: bockw: Enable SCI and TMU using DT
Message-ID: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this series is to enable SCI and TMU using DT
on the r8a7778 (R-Car M1) based bockw when booting using DT reference.

This is the first batck of work by myself to convert DT reference
board support to initialsie SCI and TMU devices using DT.


This series is depends on patches included in
"[PATCH v4 00/19] Renesas CMT, MTU2 and TMU timers DT support" which
applies on top of renesas-devel-v3.16-rc2-20140628.

The patch "bockw: Initialise SCIF device using DT"
depends on "serial: sh-sci: Add device tree support for r8a7778".

Simon Horman (6):
  ARM: shmobile: r8a7778: add SCI clock support for DT
  ARM: shmobile: r8a7778: Add SCIF nodes
  ARM: shmobile: bockw: Initialise SCIF device using DT
  ARM: shmobile: r8a7778: add TMU clock support for DT
  ARM: shmobile: r8a7778: Add TMU nodes
  ARM: shmobile: bockw: Initialise TMU device using DT

 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 18 +++++-
 arch/arm/boot/dts/r8a7778.dtsi                | 84 +++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7778.c        |  8 +++
 arch/arm/mach-shmobile/setup-r8a7778.c        | 15 +++--
 4 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.0.0.rc2
